import 'package:json_annotation/json_annotation.dart';

part '../../generated/models/common/app_config.g.dart';

@JsonSerializable(createToJson: false)
class AppConfig {
  final int fileSizeLimitBytes;
  final String contactEmail;
  String? appVersion;

  int get fileSizeLimitKilobytes => fileSizeLimitBytes ~/ 1024;
  int get fileSizeLimitMegabytes => fileSizeLimitKilobytes ~/ 1024;

  AppConfig({
    required this.fileSizeLimitBytes,
    required this.contactEmail,
    this.appVersion,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);
}
