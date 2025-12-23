import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  String _language = 'es';
  bool _voiceEnabled = true;
  bool _offlineMode = false;

  bool get isDarkMode => _isDarkMode;
  String get language => _language;
  bool get voiceEnabled => _voiceEnabled;
  bool get offlineMode => _offlineMode;

  SettingsProvider() {
    _loadSettings();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    _saveSettings();
    notifyListeners();
  }

  void setLanguage(String language) {
    _language = language;
    _saveSettings();
    notifyListeners();
  }

  void toggleVoiceEnabled() {
    _voiceEnabled = !_voiceEnabled;
    _saveSettings();
    notifyListeners();
  }

  void toggleOfflineMode() {
    _offlineMode = !_offlineMode;
    _saveSettings();
    notifyListeners();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _language = prefs.getString('language') ?? 'es';
    _voiceEnabled = prefs.getBool('voiceEnabled') ?? true;
    _offlineMode = prefs.getBool('offlineMode') ?? false;
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    await prefs.setString('language', _language);
    await prefs.setBool('voiceEnabled', _voiceEnabled);
    await prefs.setBool('offlineMode', _offlineMode);
  }
}