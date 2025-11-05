import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

/// Encryption and hashing utilities
class EncryptionHelper {
  static final _key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1'); // 32 chars
  static final _iv = encrypt.IV.fromLength(16);
  static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));
  
  /// Encrypt a string
  static String encryptString(String plainText) {
    try {
      final encrypted = _encrypter.encrypt(plainText, iv: _iv);
      return encrypted.base64;
    } catch (e) {
      throw Exception('Encryption failed: $e');
    }
  }
  
  /// Decrypt a string
  static String decryptString(String encryptedText) {
    try {
      final decrypted = _encrypter.decrypt64(encryptedText, iv: _iv);
      return decrypted;
    } catch (e) {
      throw Exception('Decryption failed: $e');
    }
  }
  
  /// Hash a password using SHA-256
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  
  /// Hash a password with salt
  static String hashPasswordWithSalt(String password, String salt) {
    final combined = password + salt;
    final bytes = utf8.encode(combined);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  
  /// Generate a random salt
  static String generateSalt() {
    final random = DateTime.now().millisecondsSinceEpoch.toString();
    return hashPassword(random);
  }
  
  /// Verify password against hash
  static bool verifyPassword(String password, String hash, {String? salt}) {
    if (salt != null) {
      return hashPasswordWithSalt(password, salt) == hash;
    }
    return hashPassword(password) == hash;
  }
  
  /// Generate MD5 hash
  static String generateMD5(String input) {
    final bytes = utf8.encode(input);
    final digest = md5.convert(bytes);
    return digest.toString();
  }
  
  /// Encrypt sensitive data (like tokens)
  static String encryptSensitiveData(String data) {
    return encryptString(data);
  }
  
  /// Decrypt sensitive data
  static String decryptSensitiveData(String encryptedData) {
    return decryptString(encryptedData);
  }
}

