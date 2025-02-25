import 'package:flutter/material.dart';
import 'package:flutter_demo/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:widgetbook/widgetbook.dart';
import 'widgets/text/text_styles_story.dart';

class HotReload extends StatelessWidget {
  const HotReload({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        LocalizationAddon(
          locales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'App Theme',
              data: themeData,
            ),
            WidgetbookTheme(
              name: 'Default Theme',
              data: ThemeData(),
            ),
          ],
        ),
        DeviceFrameAddon(
          devices: [
            Devices.windows.laptop,
            Devices.ios.iPhoneSE,
            Devices.ios.iPhone13,
            Devices.ios.iPadPro11Inches,
            Devices.android.samsungGalaxyA50,
          ],
        ),
      ],
      directories: [
        WidgetbookCategory(
          name: 'widgets',
          children: [
            WidgetbookComponent(
              name: 'Text',
              useCases: [
                WidgetbookUseCase.child(
                  name: 'text styles',
                  child: TextStylesStory(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
