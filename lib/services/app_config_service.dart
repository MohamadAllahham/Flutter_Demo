import 'dart:async';

import 'package:flutter_common/logging.dart';
import 'package:flutter_common/network/api_service.dart';
import 'package:flutter_demo/models/common/app_config.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:universal_html/html.dart';

class AppConfigService {
  static final logger = createLogger(AppConfigService);

  ApiService get _apiService => GetIt.I<ApiService>();
  late final AppConfig appConfig;

  Future<AppConfigService> init() async {
    try {
      final response = await _apiService.get('config');
      appConfig = AppConfig.fromJson(response.asMap());
      appConfig.appVersion = (await PackageInfo.fromPlatform()).version;
    } catch (e) {
      logger.e(e);
      window.location.reload();
    }
    return this;
  }
}
