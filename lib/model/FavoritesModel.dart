import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

class FavoritesModel extends ChangeNotifier {
  
  List<String> _favorites = [];
  List<String> get favorites => _favorites;

  void add(String coins){
    _favorites.add(coins);
    notifyListeners();
  }

  void remove(String coins){
    _favorites.remove(coins);
    notifyListeners();
  }
}

class Storage {
    Future<String> get _localPath async {
      final directory = await getApplicationDocumentsDirectory();

      return directory.path;
    }
    Future<File> get _localFile async {
      final path = await _localPath;
      return File('$path/favorites.txt');
    }

    Future<String> readData() async{
      try{
        final file = await _localFile;
        String contents = await file.readAsString();
        return contents;
      }
      catch(e){
        return e.toString();
      }
    }

    Future<File> writeData(String data) async{
      final file = await  _localFile;
      return file.writeAsString("$data");
    }
}