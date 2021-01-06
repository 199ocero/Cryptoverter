import 'package:Cryptoverter/pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:Cryptoverter/model/FavoritesModel.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());

const PrimaryColor = const Color(0xff212244);
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoritesModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          
          primaryColor: PrimaryColor,
        ),
        home: Hompage(),
      ),
    );
  }
}