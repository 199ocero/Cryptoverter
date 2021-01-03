import 'package:Cryptoverter/api/Coins.dart';
import 'package:Cryptoverter/api/Services.dart';
import 'package:Cryptoverter/model/FavoritesModel.dart';
import 'package:Cryptoverter/pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getCoins().then((coins) {
      setState(() {
        _coins = coins;
        _loading = false;
      });
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCodeOnly(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Favorites',style: TextStyle(fontWeight: FontWeight.normal, letterSpacing: 5, fontSize: 15)),
      ),
      body: Consumer<FavoritesModel>(
        builder: (context,favorites,child){
          for(var i=0;i<favorites.favorites.length;i++){
            for(var j=0;j<_coins.length;j++){
              if(favorites.favorites[i]==_coins[j].name){
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
                child: ListTile(
                  title: Text(_name[index]),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_symbol[index]),
                      Text('\$'+ price),
                      Text('24 Hours: '+percentage_24.toStringAsFixed(2)+'%',style: TextStyle(color: Colors.redAccent),),

                    ],
                  ),
                  trailing: (favorites.favorites.contains(_name[index])) ? IconButton(icon: Icon(Icons.favorite,color: Colors.redAccent)):
                  IconButton(icon: Icon(Icons.favorite),),
                  onTap: (){
                    if(favorites.favorites.contains(_name[index])){
                      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Favorites()));
                      favorites.favorites.remove(_name[index]);
                    }else{
                      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Favorites()));
                      favorites.favorites.add(_name[index]);
                    }
                  },
                ),
              );
            } else {
                return Card(
                child: ListTile(
                  title: Text(_name[index]),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_symbol[index]),
                      Text('\$'+ price),
                      Text('24 Hours: '+percentage_24.toStringAsFixed(2)+'%',style: TextStyle(color: Colors.green),),
                    ],
                  ),
                  trailing: (favorites.favorites.contains(_name[index])) ? IconButton(icon: Icon(Icons.favorite,color: Colors.redAccent)):
                  IconButton(icon: Icon(Icons.favorite),),
                  onTap: (){
                    if(favorites.favorites.contains(_name[index])){
                      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Favorites()));
                      favorites.favorites.remove(_name[index]);
                    }else{
                      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Favorites()));
                      favorites.favorites.add(_name[index]);
                    }
                  },
                ),
              );
            }
            
          });
        },
      ),
    );
  }
}

