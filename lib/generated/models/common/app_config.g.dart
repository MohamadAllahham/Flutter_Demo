// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../models/common/app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => $checkedCreate(
      'AppConfig',
      json,
      ($checkedConvert) {
        final val = AppConfig(
          fileSizeLimitBytes:
              $checkedConvert('fileSizeLimitBytes', (v) => (v as num).toInt()),
          contactEmail: $checkedConvert('contactEmail', (v) => v as String),
          appVersion: $checkedConvert('appVersion', (v) => v as String?),
        );
        return val;
      },
    );
