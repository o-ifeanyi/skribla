// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:typed_data';

Future<void> shareImage(ByteData byteData, String fileName) async {
  final url = html.Url.createObjectUrlFromBlob(
    html.Blob([byteData.buffer.asUint8List()], 'image/png'),
  );

  html.AnchorElement(href: url)
    ..setAttribute('download', fileName)
    ..click();

  html.Url.revokeObjectUrl(url);
}

String get localeName => html.window.navigator.language;
