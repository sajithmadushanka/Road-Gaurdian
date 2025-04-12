import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<XFile?> compressXFile(XFile file) async {
  final targetPath = file.path.replaceFirst('.jpg', '_compressed.jpg');

  final compressedFile = await FlutterImageCompress.compressAndGetFile(
    file.path,
    targetPath,
    quality: 10,
  );

  if (compressedFile == null) return null;

  return XFile(compressedFile.path);
}
