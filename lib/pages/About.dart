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
      body:Container(
        child: Center(
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
              Container(
                width: 300,
                margin: const EdgeInsets.only(left: 0.0, right: 0.0,top: 20,bottom: 0.0),
                child: Text(
                  'It is an application that shows different cryptocurrency with its default prices in US dollars. You can check also the different prices of cryptocurrency in fiat/real money by using the converter section.\n\nIf you want to know more about this app, get in touch with us:\n\nZone-3, Ane-i, Claveria\nMisamis Oriental 9001\n+63 932 272 1987\n199ocero@gmail.com\n\nAll Rights Reserved.\nCryptoverter @ 2020',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white54,fontSize: 12,letterSpacing: 1)
                ),
              ), 
            ],
          ),
        ),
      ),
    );
  }
}