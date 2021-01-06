class Convert{

  Map<String, dynamic> ticker;

  String base,target,price,change;

  Convert({this.ticker,this.base,this.target,this.price,this.change});
  
  factory Convert.createJSON(Map<String,dynamic> json){
    return Convert(
      ticker: json['ticker'],
      base: json['base'],
      price: json['price'],
      target: json['target'],
      change: json['change'],
    );

  }
}

// class CoinsFinal{
//   String symbol;

//   CoinsFinal({this.symbol});

//   factory CoinsFinal.fromJson(dynamic json){
//     return new CoinsFinal(
//       symbol: json['symbol'] as String
//     );
//   }
//   @override
//   String toString() {
//     return '${this.symbol}';
//   }
// }

// class CoinsList {
//   final List<CoinsFinal> coins;

//   CoinsList({
//     this.coins,
//   });

//   factory CoinsList.fromJson(List<dynamic> parsedJson) {

//     List<CoinsFinal> coins = new List<CoinsFinal>();
//     coins = parsedJson.map((i)=>CoinsFinal.fromJson(i)).toList();

//     return new CoinsList(
//       coins: coins
//     );
//   }
// }

