import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

Future<Database> getDatabase() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  var dbPath = join(documentsDirectory.path, "grade.db");

  await deleteDatabase(dbPath);

  ByteData data = await rootBundle.load("lib/database/grade.db");
  List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  await File(dbPath).writeAsBytes(bytes);

  return await openDatabase(dbPath);
}