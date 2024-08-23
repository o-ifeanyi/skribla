// ignore_for_file: avoid_print, avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final file = File('bin/resource/words.json');
  final duplicates = await checkDuplicates(file);
  if (duplicates.isNotEmpty) {
    print('Duplicates entries found:');
    for (final entry in duplicates) {
      print('- $entry');
    }
  } else {
    print('No duplicates found');
  }
}

Future<List<String>> checkDuplicates(File file) async {
  final jsonString = await file.readAsString();
  final data = json.decode(jsonString) as List;

  final textSet = <String>{};
  final duplicates = <String>[];

  print('Searching for duplicates in ${file.path} with ${data.length} entries');

  for (final item in data) {
    final text = (item['text'] as String).toLowerCase();
    if (textSet.contains(text)) {
      duplicates.add(text);
    } else {
      textSet.add(text);
    }
  }

  return duplicates;
}
