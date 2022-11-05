import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManager {
  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await localPath;
    return File('$path/pickup.json');
  }

  static Future<File> get _pendingLocalFile async {
    final path = await localPath;
    return File('$path/pickupPending.json');
  }

  static Future<List<dynamic>> readPickup({bool isPending = false}) async {
    try {
      final file = await _localFile;

      final pendingFile = await _pendingLocalFile;
      if (isPending) {
        final contents = await pendingFile.readAsString();

        return json.decode(contents);
      }
      // Read the file
      final contents = await file.readAsString();

      return json.decode(contents);
    } catch (e) {
      return [];
    }
  }

  static Future<File> writePickup(List<dynamic> shipmentEntity) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(json.encode(shipmentEntity));
  }
}
