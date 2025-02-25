import 'package:flutter_demo/models/common/profile_type.dart';

abstract class ProfileEntity {
  ProfileType get profileType;
  String get id;
  String get name;
  String? get pictureId;
}
