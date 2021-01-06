import 'package:Cryptoverter/api/Coins.dart';
import 'package:Cryptoverter/api/Services.dart';
import 'package:Cryptoverter/model/FavoritesModel.dart';
import 'package:Cryptoverter/pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';

class Cryptolist extends StatefulWidget {
  @override
  _CryptolistState createState() => _CryptolistState();
}

class _CryptolistState extends State<Cryptolist> {
  List<Coins> _coins = [];
  bool _loading;
  final LocalStorage _favorites = new LocalStorage('favorites');
  final CryptoFavoritesList _favoritesList = CryptoFavoritesList();
  
  @override
  void initState() {
    super.initState();
    _loadData();
    _loading = true;
    Services.getCoins().then((coins) {
      setState(() {
        _coins = coins;
        _loading = false;
      });
    });

    
  }

  _loadData() async{
    await _favorites.ready;
    // _favorites.clear();
    if(_favorites.getItem('favorites')==null){
      _favorites.setItem('favorites', _favoritesList.toJSONEncodable());
    }else{
      _favoritesList.toList(_favorites.getItem('favorites'));
    }
  }

  
  @override
  Widget build(BuildContext context) {
    const PrimaryColor = const Color(0xff212244);
    return Scaffold(
      drawer: DrawerCodeOnly(),
      backgroundColor: PrimaryColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(_loading ? 'Fetching data...' : 'Crypto List',style: TextStyle(fontWeight: FontWeight.normal, letterSpacing: 5, fontSize: 15)),
      ),
      body: Consumer<FavoritesModel>(
        builder: (context,favorites,child){
          favorites.favorites.clear();
          for (var i = 0; i < _favoritesList.items.length; i++) {
            favorites.favorites.add(_favorites.getItem('favorites')[i]['symbol']);
          }
          return RefreshIndicator(
          color: PrimaryColor,
          onRefresh: () {
            Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Cryptolist()));
            return Future.value(false);
           },
          child: ListView.builder(
            itemCount: _coins.length,
            itemBuilder: (context, index){
            Coins coin = _coins[index];
            
            var price = NumberFormat.simpleCurrency().format(double.parse(coin.priceUsd));
            var percentage_24 = double.parse(coin.percentChange24H);
            if (percentage_24<0) {
                return Card(
                child: Container(
                  color: PrimaryColor,
                  child: ListTile(
                    title: Text(coin.name,style: TextStyle(color: Colors.grey),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(coin.symbol,style: TextStyle(color: Colors.grey),),
                        Text(price,style: TextStyle(color: Colors.grey),),
                        Text('24 Hours: '+percentage_24.toStringAsFixed(2)+'%',style: TextStyle(color: Colors.redAccent),),

                      ],
                    ),
                    trailing: (favorites.favorites.contains(coin.symbol)) ? IconButton(icon: Icon(Icons.favorite,color: Colors.redAccent)):
                    IconButton(icon: Icon(Icons.favorite),),
                    onTap: () async{
                      await _favorites.ready;
                      CryptoFavorites data = CryptoFavorites(symbol:coin.symbol);
                      if(favorites.favorites.contains(coin.symbol)){
                        _favoritesList.items.removeWhere((e)=> e.symbol == coin.symbol);
                        _favorites.setItem('favorites', _favoritesList.toJSONEncodable());
                        Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Cryptolist()));
                        
                      }else{
                        Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Cryptolist()));
                        _favoritesList.items.add(data);
                        _favorites.setItem('favorites', _favoritesList.toJSONEncodable());
                      }
                    },
                  ),
                ),
              );
            } else {
                return Card(
                child: Container(
                  color: PrimaryColor,
                  child: ListTile(
                    title: Text(coin.name,style: TextStyle(color: Colors.grey),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(coin.symbol,style: TextStyle(color: Colors.grey),),
                        Text(price,style: TextStyle(color: Colors.grey),),
                        Text('24 Hours: '+percentage_24.toStringAsFixed(2)+'%',style: TextStyle(color: Colors.green),),
                      ],
                    ),
                    trailing: (favorites.favorites.contains(coin.symbol)) ? IconButton(icon: Icon(Icons.favorite,color: Colors.redAccent)):
                    IconButton(icon: Icon(Icons.favorite),),
                    onTap: () async{
                      await _favorites.ready;
                      CryptoFavorites data = CryptoFavorites(symbol:coin.symbol);
                      if(favorites.favorites.contains(coin.symbol)){
                        _favoritesList.items.removeWhere((e)=> e.symbol == coin.symbol);
                        _favorites.setItem('favorites', _favoritesList.toJSONEncodable());
                        Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Cryptolist()));
                        
                      }else{
                        Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Cryptolist()));
                        _favoritesList.items.add(data);
                        _favorites.setItem('favorites', _favoritesList.toJSONEncodable());
                      }
                    },
                  ),
                ),
              );
            }
            
          }),
          );
        },
        
      ),
    );
  }
  
}