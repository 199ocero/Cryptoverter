import 'package:http/http.dart' as http;
import 'package:Cryptoverter/api/Coins.dart';


class Services{
  static const String url = 'https://api.alternative.me/v1/ticker/?limit=10';

  static Future<List<Coins>> getCoins() async{
    try{
      final response = await http.get(url);
      if(response.statusCode == 200){
        final List<Coins> coins = coinsFromJson(response.body);
        return coins;
      }else{
        return List<Coins>();
      }
    }catch(e){
      return List<Coins>();
    }
  }
}
