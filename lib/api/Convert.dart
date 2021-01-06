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
