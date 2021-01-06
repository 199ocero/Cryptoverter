import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:Cryptoverter/api/Convert.dart';
import 'package:Cryptoverter/pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CryptoConverter extends StatefulWidget {
  @override
  _CryptoConverterState createState() => _CryptoConverterState();
}

class _CryptoConverterState extends State<CryptoConverter> {

  
  
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCodeOnly(),
      backgroundColor: Color(0xff212244),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Converter',style: TextStyle(fontWeight: FontWeight.normal, letterSpacing: 5, fontSize: 15)),
      ),
      body: MyStatefulWidget(),
    ); 
  }
  
}
/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Future<Convert> _data;
  String _base = 'BTC';
  String _target = 'USD';
  String _price = '0.00';

  
  void initState(){
    super.initState();
    fetchAPI(http.Client());
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 70),
      child: Column(
        children: <Widget> [
          DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: _base,
                  iconSize: 24,
                  style: TextStyle(color: Colors.grey),
                  onChanged: (String newValue) {
                    setState(() {
                      _base = newValue;
                    });
                  },
                  items: <String>['BTC', 'ETH', 'USDT', 'LTC','XRP','DOT','ADA','BCH','BNB','LINK']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(fontSize: 20),),
                    );
                  }).toList(),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                fetchAPI(http.Client());
              },
              color: Color(0xff2F4BFB),
              textColor: Colors.white,
              child: Icon(
                Icons.arrow_drop_down,
                size: 50,
              ),
              shape: CircleBorder(),
            ),
           DropdownButtonHideUnderline(
             child: ButtonTheme(
               alignedDropdown: true,
               child: DropdownButton<String>(
                  value: _target,
                  iconSize: 24,
                  style: TextStyle(color: Colors.grey),
                  onChanged: (String newValue) {
                    setState(() {
                      _target = newValue;
                    });
                  },
                  items: <String>['USD', 'EUR', 'GBP', 'CAD', 'AUD','JPY']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(fontSize: 20),),
                    );
                  }).toList(),
                ),
             ),
           ),
          Container(
            child: ListTile(
              title: Chip(label: Container(
                width: 300,
                height: 50,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '$_price',style: TextStyle(color: Colors.white,fontSize: 30),),
                )),backgroundColor: Color(0xff2F4BFB),),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 0.0, right: 0.0,top: 20,bottom: 0.0),
            child: Text(
              'Note: We use 1 value of any cryptocurrency to be converted real/fiat money.',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey,fontSize: 10,)
            ),
          ),  
        ],
      ),
    );
  }
  Future<Convert> fetchAPI(http.Client client) async{
      final response = await client.get('https://api.cryptonator.com/api/ticker/$_base-$_target');
      final parseData = jsonDecode(response.body).cast<String,dynamic>();
      
      switch (_target) {
        case 'USD':
          var price = NumberFormat.simpleCurrency().format(double.parse(parseData['ticker']['price']));
          setState(() {
            _price = price;
          });
          break;
        case 'EUR':
          var price = NumberFormat.simpleCurrency(name: '€').format(double.parse(parseData['ticker']['price']));
          setState(() {
            _price = price;
          });
          break;
        case 'GBP':
          var price = NumberFormat.simpleCurrency(name: '£').format(double.parse(parseData['ticker']['price']));
          setState(() {
            _price = price;
          });
          break;
        case 'CAD':
          var price = NumberFormat.simpleCurrency().format(double.parse(parseData['ticker']['price']));
          setState(() {
            _price = price;
          });
          break;
        case 'AUD':
          var price = NumberFormat.simpleCurrency().format(double.parse(parseData['ticker']['price']));
          setState(() {
            _price = price;
          });
          break;
        case 'JPY':
          var price = NumberFormat.simpleCurrency(name: '¥').format(double.parse(parseData['ticker']['price']));
          setState(() {
            _price = price;
          });
          break;
        default:
          var price = NumberFormat.simpleCurrency().format(double.parse(parseData['ticker']['price']));
            setState(() {
              _price = price;
            });
          break;
      }
      return Convert.createJSON(parseData);
  }


}
