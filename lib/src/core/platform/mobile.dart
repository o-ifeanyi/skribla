import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareImage(ByteData byteData, String fileName) async {
  final dir = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationSupportDirectory();

  if (dir == null) return;

  // delete previous screenshots
  final files = dir.listSync();
  for (final file in files) {
    if (file.path.contains('screenshot')) {
      file.deleteSync();
    }
  }

  final file = await File('${dir.path}/$fileName').create();

  await file.writeAsBytes(byteData.buffer.asUint8List());

  await Share.shareXFiles([XFile(file.path)]);
}
