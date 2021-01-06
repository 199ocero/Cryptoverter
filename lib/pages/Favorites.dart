import 'package:Cryptoverter/api/Coins.dart';
import 'package:Cryptoverter/api/Services.dart';
import 'package:Cryptoverter/model/FavoritesModel.dart';
import 'package:Cryptoverter/pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localstorage/localstorage.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Coins> _coins = [];
  List<String> _name=[];
  List<String> _symbol=[];
  List<String> _price=[];
  List<String> _change24=[];
  final LocalStorage _favorites = new LocalStorage('favorites');
  final CryptoFavoritesList _favoritesList = CryptoFavoritesList();
  bool _loading;

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
        title: Text('Favorites',style: TextStyle(fontWeight: FontWeight.normal, letterSpacing: 5, fontSize: 15)),
      ),
      body: Consumer<FavoritesModel>(
        builder: (context,favorites,child){
          favorites.favorites.clear();
          for (var i = 0; i < _favoritesList.items.length; i++) {
            favorites.favorites.add(_favorites.getItem('favorites')[i]['symbol']);
          }
          if(favorites.favorites.length>0){
            for(var i=0;i<favorites.favorites.length;i++){
              for(var j=0;j<_coins.length;j++){
                if(favorites.favorites[i]==_coins[j].symbol){
                  _name.add(_coins[j].name);
                  _symbol.add(_coins[j].symbol);
                  _price.add(_coins[j].priceUsd);
                  _change24.add(_coins[j].percentChange24H);
                }
              }
            }
            return ListView.builder(
              itemCount:_symbol.length,
              itemBuilder: (context, index){
              var price = double.parse(_price[index]).toStringAsFixed(2);
              var percentage_24 = double.parse(_change24[index]);
              if (percentage_24<0) {
                  return Card(
                  child: Container(
                    color: PrimaryColor,
                    child: ListTile(
                      title: Text(_name[index],style: TextStyle(color: Colors.grey),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_symbol[index],style: TextStyle(color: Colors.grey),),
                          Text('\$'+ price,style: TextStyle(color: Colors.grey),),
                          Text('24 Hours: '+percentage_24.toStringAsFixed(2)+'%',style: TextStyle(color: Colors.redAccent),),

                        ],
                      ),
                      trailing: (favorites.favorites.contains(_symbol[index])) ? IconButton(icon: Icon(Icons.favorite,color: Colors.redAccent)):
                      IconButton(icon: Icon(Icons.favorite),),
                      onTap: ()async{
                        await _favorites.ready;
                        CryptoFavorites data = CryptoFavorites(symbol:_symbol[index]);
                        if(favorites.favorites.contains(_symbol[index])){
                          _favoritesList.items.removeWhere((e)=> e.symbol == _symbol[index]);
                          _favorites.setItem('favorites', _favoritesList.toJSONEncodable());
                          Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Favorites()));
                        }else{
                          _favoritesList.items.add(data);
                          _favorites.setItem('favorites', _favoritesList.toJSONEncodable());
                          Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Favorites()));
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
                      title: Text(_name[index],style: TextStyle(color: Colors.grey),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_symbol[index],style: TextStyle(color: Colors.grey),),
                          Text('\$'+ price,style: TextStyle(color: Colors.grey),),
                          Text('24 Hours: '+percentage_24.toStringAsFixed(2)+'%',style: TextStyle(color: Colors.green),),
                        ],
                      ),
                      trailing: (favorites.favorites.contains(_symbol[index])) ? IconButton(icon: Icon(Icons.favorite,color: Colors.redAccent)):
                      IconButton(icon: Icon(Icons.favorite),),
                      onTap: ()async{
                        await _favorites.ready;
                        CryptoFavorites data = CryptoFavorites(symbol:_symbol[index]);
                        if(favorites.favorites.contains(_symbol[index])){
                          _favoritesList.items.removeWhere((e)=> e.symbol == _symbol[index]);
                          _favorites.setItem('favorites', _favoritesList.toJSONEncodable());
                          Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Favorites()));
                        }else{
                          
                          _favoritesList.items.add(data);
                          _favorites.setItem('favorites', _favoritesList.toJSONEncodable());
                          Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Favorites()));
                        }
                      },
                    ),
                  ),
                );
              }
              
            });
          }else{
            return Align(
              alignment: Alignment.center, // Align however you like (i.e .centerRight, centerLeft)
              child: Text("No favorites yet.",style: TextStyle(color: Colors.white),),
            );
            
          }
          
        },
      ),
    );
  }
}

