
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// AINDA FALTA CORRIGIR ESSA FUNÇÃO

Future<Database> getDatabase() async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "grade.db");

  if(!kIsWeb) {
    await Directory(dirname(path)).create(recursive: true);
    ByteData data = await rootBundle.load("lib/database/grade.db");

    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes, flush: true);
  }

  else {
    var dbFile = html.window.localStorage['grade.db'];
    if(dbFile == null){
      ByteData data = await rootBundle.load("lib/database/grade.db");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      html.window.localStorage['grade.db'] = base64Encode(bytes);
    }
    else {
      var bytes = base64Decode(dbFile);
      await File(path).writeAsBytes(bytes, flush: true);
    }
  }

  return openDatabase(path);
}