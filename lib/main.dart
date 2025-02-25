import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common/logging.dart';
import 'package:flutter_common/network/api_service.dart';
import 'package:flutter_common/network/browser_service.dart';
import 'package:flutter_common/network/error_interceptor.dart';
import 'package:flutter_common/network/logging_interceptor.dart';

import 'package:flutter_common/platform/io_platform.dart';
import 'package:flutter_demo/services/app_config_service.dart';
import 'package:flutter_demo/services/legalities_service.dart';
import 'package:flutter_demo/services/nav_service.dart';
import 'package:flutter_demo/services/settings_service.dart';
import 'package:flutter_demo/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'app_router.dart';
import 'app_router.gr.dart';
import 'models/common/language.dart';

Future<void> main() async {
  runZonedGuarded(() {
    Future(() async {
      await _initEnv();

      WidgetsFlutterBinding.ensureInitialized();

      // allow any device orientation
      await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

      // final deviceToken = await _initFirebase();

      await registerServices();
      runApp(
        App(
          key: GetIt.I<SettingsService>().appStateKey,
          language:
           Language.german,
        ),
      );
    });
  }, (error, stackTrace) {
    // workaround to prevent missing network image logs
    // https://github.com/flutter/flutter/issues/69125 (closed as duplicate)
    if (error is NetworkImageLoadException) return;
    App.logger.e(error);
    App.logger.e(stackTrace);
  });
}

Future<void> registerServices() async {
  // router must not be initialized inside of a build-method
  final appRouter = AppRouter();
  //GetIt.I.registerSingleton(appRouter);
  GetIt.I.registerSingleton(
    NavService(
      appRouter,
      defaultRoute: HomeRoute(),
    ),
  );
  final browserService = BrowserService();
  GetIt.I.registerSingleton(browserService);

   final apiService = ApiService(
     apiUrl: dotenv.get('API_URL'),
     initialInterceptors: [LoggingInterceptor()],
   );
   GetIt.I.registerSingleton(apiService);
   GetIt.I.registerSingleton(LegalitiesService(browserService, apiService));

   apiService.addInterceptor(ErrorInterceptor());
   GetIt.I.registerSingleton(SettingsService());
   GetIt.I.registerSingletonAsync(AppConfigService().init);

   await GetIt.I.allReady();
}

Future<void> _initEnv() async {
  final platform = initPlatform();
  String envFilePath() {
    if (platform.isRelease) return 'dotenv.prod';
    return 'dotenv.dev';
  }

  await dotenv.load(fileName: envFilePath());
}


class App extends StatefulWidget {
  static final logger = createLogger(App);
  final Language language;

  const App({super.key, required this.language});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  late Language _language;
  Language get language => _language;
  set language(Language value) {
    setState(() {
      _language = value;
    });
  }

  @override
  void initState() {
    super.initState();
    language = widget.language;
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = GetIt.I<AppRouter>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Demo',
      theme: themeData,
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(_language.languageCode),
    );
  }
}
