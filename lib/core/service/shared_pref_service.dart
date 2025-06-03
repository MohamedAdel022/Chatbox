import 'package:shared_preferences/shared_preferences.dart';

/// A singleton service that provides shared preferences functionality
class SharedPreferencesService {
  // Private constructor to prevent direct instantiation
  SharedPreferencesService._();
  
  // Static instance of the singleton
  static SharedPreferencesService? _instance;
  
  // The actual SharedPreferences instance
  static late SharedPreferences _prefs;
  
  // Factory constructor that returns the singleton instance
  factory SharedPreferencesService() {
    _instance ??= SharedPreferencesService._();
    return _instance!;
  }
  
  // Initialize the shared preferences service
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  // String operations
  
  // Get a string value (synchronous)
  String? getString(String key) {
    return _prefs.getString(key);
  }
  
  // Set a string value (asynchronous)
  static Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }
  
  // Int operations
  
  // Get an int value (synchronous)
  int? getInt(String key) {
    return _prefs.getInt(key);
  }
  
  // Set an int value (asynchronous)
  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }
  
  // Bool operations
  
  // Get a bool value (synchronous)
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }
  
  // Set a bool value (asynchronous)
  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }
  
  // Double operations
  
  // Get a double value (synchronous)
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }
  
  // Set a double value (asynchronous)
  Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }
  
  // String list operations
  
  // Get a string list value (synchronous)
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }
  
  // Set a string list value (asynchronous)
  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }
  
  // Common operations
  
  // Check if key exists (synchronous)
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
  
  // Remove a value (asynchronous)
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }
  
  // Clear all values (asynchronous)
  Future<bool> clear() async {
    return await _prefs.clear();
  }
  
  // Get all keys (synchronous)
  Set<String> getKeys() {
    return _prefs.getKeys();
  }
  
  // Reload shared preferences from disk (asynchronous)
  Future<void> reload() async {
    await _prefs.reload();
  }
}
