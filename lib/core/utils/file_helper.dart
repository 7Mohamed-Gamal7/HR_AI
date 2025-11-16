import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';
import '../constants/app_constants.dart';

/// File operation utilities
class FileHelper {
  /// Get file extension
  static String getFileExtension(String filePath) {
    return path.extension(filePath).toLowerCase().replaceAll('.', '');
  }
  
  /// Get file name without extension
  static String getFileNameWithoutExtension(String filePath) {
    return path.basenameWithoutExtension(filePath);
  }
  
  /// Get file name with extension
  static String getFileName(String filePath) {
    return path.basename(filePath);
  }
  
  /// Get file size in bytes
  static Future<int> getFileSize(String filePath) async {
    final file = File(filePath);
    return await file.length();
  }
  
  /// Get file size in human-readable format
  static Future<String> getFileSizeFormatted(String filePath) async {
    final bytes = await getFileSize(filePath);
    return formatBytes(bytes);
  }
  
  /// Format bytes to human-readable format
  static String formatBytes(int bytes, {int decimals = 2}) {
    if (bytes <= 0) return '0 B';
    
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    final i = (bytes.bitLength - 1) ~/ 10;
    final size = bytes / (1 << (i * 10));
    
    return '${size.toStringAsFixed(decimals)} ${suffixes[i]}';
  }
  
  /// Check if file exists
  static Future<bool> fileExists(String filePath) async {
    final file = File(filePath);
    return await file.exists();
  }
  
  /// Delete file
  static Future<void> deleteFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
  
  /// Copy file
  static Future<void> copyFile(String sourcePath, String destinationPath) async {
    final sourceFile = File(sourcePath);
    await sourceFile.copy(destinationPath);
  }
  
  /// Move file
  static Future<void> moveFile(String sourcePath, String destinationPath) async {
    final sourceFile = File(sourcePath);
    await sourceFile.rename(destinationPath);
  }
  
  /// Get MIME type
  static String? getMimeType(String filePath) {
    return lookupMimeType(filePath);
  }
  
  /// Check if file is image
  static bool isImage(String filePath) {
    final extension = getFileExtension(filePath);
    return AppConstants.allowedImageExtensions.contains(extension);
  }
  
  /// Check if file is document
  static bool isDocument(String filePath) {
    final extension = getFileExtension(filePath);
    return AppConstants.allowedDocumentExtensions.contains(extension);
  }
  
  /// Validate file size
  static Future<bool> validateFileSize(String filePath, int maxSize) async {
    final size = await getFileSize(filePath);
    return size <= maxSize;
  }
  
  /// Validate file extension
  static bool validateFileExtension(String filePath, List<String> allowedExtensions) {
    final extension = getFileExtension(filePath);
    return allowedExtensions.contains(extension);
  }
  
  /// Create directory if not exists
  static Future<void> createDirectory(String directoryPath) async {
    final directory = Directory(directoryPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
  }
  
  /// Delete directory
  static Future<void> deleteDirectory(String directoryPath) async {
    final directory = Directory(directoryPath);
    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }
  }
  
  /// List files in directory
  static Future<List<FileSystemEntity>> listFiles(String directoryPath) async {
    final directory = Directory(directoryPath);
    return await directory.list().toList();
  }
  
  /// Read file as string
  static Future<String> readFileAsString(String filePath) async {
    final file = File(filePath);
    return await file.readAsString();
  }
  
  /// Write string to file
  static Future<void> writeStringToFile(String filePath, String content) async {
    final file = File(filePath);
    await file.writeAsString(content);
  }
  
  /// Read file as bytes
  static Future<List<int>> readFileAsBytes(String filePath) async {
    final file = File(filePath);
    return await file.readAsBytes();
  }
  
  /// Write bytes to file
  static Future<void> writeBytesToFile(String filePath, List<int> bytes) async {
    final file = File(filePath);
    await file.writeAsBytes(bytes);
  }
  
  /// Generate unique file name
  static String generateUniqueFileName(String originalFileName) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = getFileExtension(originalFileName);
    final nameWithoutExt = getFileNameWithoutExtension(originalFileName);
    return '${nameWithoutExt}_$timestamp.$extension';
  }
  
  /// Sanitize file name (remove special characters)
  static String sanitizeFileName(String fileName) {
    return fileName.replaceAll(RegExp(r'[^\w\s.-]'), '_');
  }
}

