import 'package:Cryptoverter/pages/Homepage.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCodeOnly(),
      backgroundColor: Color(0xff212244),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('About Us',style: TextStyle(fontWeight: FontWeight.normal, letterSpacing: 5, fontSize: 15)),
      ),
      body: Text('I\'m About Us'),
    );
  }
}