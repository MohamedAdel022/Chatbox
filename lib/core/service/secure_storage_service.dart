import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A singleton service that provides secure storage functionality using FlutterSecureStorage
class SecureStorageService {
  // Private constructor to prevent direct instantiation
  SecureStorageService._();

  // Static instance of the singleton
  static SecureStorageService? _instance;

  // The actual storage instance
  static late FlutterSecureStorage _storage;

  // Factory constructor that returns the singleton instance
  factory SecureStorageService() {
    _instance ??= SecureStorageService._();
    return _instance!;
  }

  // Initialize the secure storage service
  static Future<void> init() async {
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
  }

  // Read a value from secure storage
   Future<String?> read({required String key}) async {
    return await _storage.read(key: key);
  }

  // Write a value to secure storage
   Future<void> write(
      {required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  // Delete a value from secure storage
   Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  // Delete all values from secure storage
   Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  // Check if a key exists in secure storage
   Future<bool> containsKey({required String key}) async {
    return await _storage.containsKey(key: key);
  }
}
