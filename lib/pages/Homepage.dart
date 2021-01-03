import 'package:Cryptoverter/api/Coins.dart';
import 'package:Cryptoverter/api/Services.dart';
import 'package:Cryptoverter/model/FavoritesModel.dart';
import 'package:Cryptoverter/pages/About.dart';
import 'package:Cryptoverter/pages/Converter.dart';
import 'package:Cryptoverter/pages/Cryptolist.dart';
import 'package:Cryptoverter/pages/Favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Hompage extends StatefulWidget {
  @override
  _HompageState createState() => _HompageState();
}

class _HompageState extends State<Hompage> {

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
      backgroundColor: Colors.white,
      drawer: DrawerCodeOnly(),
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
                      Text('24 Hours: '+percentage_24.toStringAsFixed(2)+'%',style: TextStyle(color: Colors.green),)
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

class CustomListTitle extends StatelessWidget {
  IconData icons;
  String text;
  Function onTap;
  CustomListTitle(this.icons,this.text,this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300)
          ),
        ),
        child: InkWell(
          splashColor: Color(0xff212244),
          onTap: onTap,
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Icon(icons, color: Color(0xff212244),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(text, style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff212244)
                      ),),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class DrawerCodeOnly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          children: <Widget>[
            DrawerHeader(
              
              child: Container(

                child: Column(
                  children: <Widget>[
                    Material(
                      color: Color(0xff212244),
                      child: Image.asset('images/logo.png',width: 100,height: 100,),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'C',
                        style: TextStyle(
                          color: Color(0xff2F4BFB),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5,
                        ),
                        children: [
                          TextSpan(
                            text: 'ryptoverter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 5,
                            ),
                          )
                        ],
                      ),
                    ),
                    //Text('Cryptoverter',style: TextStyle(color: Colors.white,fontSize: 20))
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xff212244),
              ),
              ),
            CustomListTitle(Icons.filter_list,'Crypto List',(){
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(builder: (context) => new Cryptolist()));
            }),
            CustomListTitle(Icons.add_circle_outline,'Converter',(){
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(builder: (context) => new CryptoConverter()));
            }),
            CustomListTitle(Icons.favorite_border,'Favorites',(){
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(builder: (context) => new Favorites()));
            }),
            CustomListTitle(Icons.person_outline,'About Us',(){
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(builder: (context) => new About()));
            }),
          ],
        ),
    );
  }
}