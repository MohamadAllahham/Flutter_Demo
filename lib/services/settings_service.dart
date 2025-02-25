import 'package:flutter_common/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/main.dart';
import 'package:flutter_demo/models/common/language.dart';
import 'package:get_it/get_it.dart';
import 'package:localstorage/localstorage.dart';

class SettingsService {
  LocalStorage get _storage => GetIt.I<LocalStorage>();
  ApiService get _apiService => GetIt.I<ApiService>();
  GlobalKey<AppState> appStateKey = GlobalKey<AppState>();
  Language get language => appStateKey.currentState!.language;
  set language(Language value) {
    _storage.setItem('language', value.name);
    appStateKey.currentState?.language = value;
  }

  // Future<User> findUser(String id) async {
  //   final response = await _apiService.get('user/$id');
  //   return User.fromJson(response.asMap());
  // }

  Future<void> updatePassword(String oldPassword, String newPassword) async {
    final fields = {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
    await _apiService.put(
      'settings',
      queryParams: {'type': 'password'},
      fields,
    );
  }

  Future<void> updateEmail(String email, String password) async {
    final fields = {
      'email': email,
      'password': password,
    };
    await _apiService.put('settings', queryParams: {'type': 'email'}, fields);
  }

  Future<void> deleteAccount() async {
    await _apiService.delete('settings');
  }

  // Future<NotificationSettings> getEmailNotificationSettings(
  //   String userId,
  // ) async {
  //   final response = await _apiService.get('notification/settings/$userId');
  //   return NotificationSettings.fromJson(response.asMap());
  // }

  Future<void> updateEmailNotificationSettings(
    String userId,
    bool doChatNotifications,
  ) async {
    final fields = {
      'userId': userId,
      'doChatNotifications': doChatNotifications,
    };
    await _apiService.put('notification/settings/$userId', fields);
  }
}
