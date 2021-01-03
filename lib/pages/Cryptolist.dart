import 'package:Cryptoverter/api/Coins.dart';
import 'package:Cryptoverter/api/Services.dart';
import 'package:Cryptoverter/model/FavoritesModel.dart';
import 'package:Cryptoverter/pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cryptolist extends StatefulWidget {
  @override
  _CryptolistState createState() => _CryptolistState();
}

class _CryptolistState extends State<Cryptolist> {
  List<Coins> _coins = [];
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
        title: Text(_loading ? 'Fetching data...' : 'Crypto List',style: TextStyle(fontWeight: FontWeight.normal, letterSpacing: 5, fontSize: 15)),
      ),
      body: Consumer<FavoritesModel>(
        builder: (context,favorites,child){
          return RefreshIndicator(
          color: Colors.white,
          onRefresh: () {
            Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Cryptolist()));
            return Future.value(false);
           },
          child: ListView.builder(
            itemCount: _coins.length,
            itemBuilder: (context, index){
            Coins coin = _coins[index];
            var price = double.parse(coin.priceUsd).toStringAsFixed(2);
            var percentage_24 = double.parse(coin.percentChange24H);
            if (percentage_24<0) {
                return Card(
                child: ListTile(
                  title: Text(coin.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(coin.symbol),
                      Text('\$'+ price),
                      Text('24 Hours: '+percentage_24.toStringAsFixed(2)+'%',style: TextStyle(color: Colors.redAccent),),

                    ],
                  ),
                  trailing: (favorites.favorites.contains(coin.name)) ? IconButton(icon: Icon(Icons.favorite,color: Colors.redAccent)):
                  IconButton(icon: Icon(Icons.favorite),),
                  onTap: (){
                    if(favorites.favorites.contains(coin.name)){
                      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Cryptolist()));
                      favorites.favorites.remove(coin.name);
                    }else{
                      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Cryptolist()));
                      favorites.favorites.add(coin.name);
                    }
                  },
                ),
              );
            } else {
                return Card(
                child: ListTile(
                  title: Text(coin.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(coin.symbol),
                      Text('\$'+ price),
                      Text('24 Hours: '+percentage_24.toStringAsFixed(2)+'%',style: TextStyle(color: Colors.green),),
                    ],
                  ),
                  trailing: (favorites.favorites.contains(coin.name)) ? IconButton(icon: Icon(Icons.favorite,color: Colors.redAccent)):
                  IconButton(icon: Icon(Icons.favorite),),
                  onTap: (){
                    if(favorites.favorites.contains(coin.name)){
                      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Cryptolist()));
                      favorites.favorites.remove(coin.name);
                    }else{
                      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>Cryptolist()));
                      favorites.favorites.add(coin.name);
                    }
                  },
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