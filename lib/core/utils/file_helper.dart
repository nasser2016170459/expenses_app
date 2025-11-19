import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class FileHelper {
  static Future<PlatformFile?> pickSingleFile({
    FileType type = FileType.custom,
    List<String>? extensions,
  }) async {
    final shouldIgnoreExtensions = !kIsWeb && type != FileType.custom;
    final result = await FilePicker.platform.pickFiles(
      type: kIsWeb ? FileType.custom : type,
      allowedExtensions: shouldIgnoreExtensions ? null : extensions,
      withData: true,
    );
    if (result != null && result.files.isNotEmpty) return result.files.single;
    return null;
  }
}
