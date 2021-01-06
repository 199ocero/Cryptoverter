import 'package:flutter/material.dart';

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

class CryptoFavorites{
   String symbol;

   CryptoFavorites({this.symbol});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();
    m['symbol'] = symbol;
    return m;
  }
}

class CryptoFavoritesList{

  List<CryptoFavorites> items;

  CryptoFavoritesList() {
    items = new List();
  }

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }

  toList(List data){
    items= List<CryptoFavorites>.from(
      // ignore: unnecessary_cast
      (data as List).map(
        (item) => CryptoFavorites(
          symbol: item['symbol']
        ),
      ),
    );
  }
}

