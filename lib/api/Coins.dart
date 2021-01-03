// To parse this JSON data, do
//
//     final coins = coinsFromJson(jsonString);

import 'dart:convert';

List<Coins> coinsFromJson(String str) => List<Coins>.from(json.decode(str).map((x) => Coins.fromJson(x)));

String coinsToJson(List<Coins> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Coins {
    Coins({
        this.id,
        this.name,
        this.symbol,
        this.rank,
        this.priceUsd,
        this.priceBtc,
        this.the24HVolumeUsd,
        this.marketCapUsd,
        this.availableSupply,
        this.totalSupply,
        this.maxSupply,
        this.percentChange1H,
        this.percentChange24H,
        this.percentChange7D,
        this.lastUpdated,
    });

    String id;
    String name;
    String symbol;
    String rank;
    String priceUsd;
    String priceBtc;
    String the24HVolumeUsd;
    String marketCapUsd;
    String availableSupply;
    String totalSupply;
    String maxSupply;
    String percentChange1H;
    String percentChange24H;
    String percentChange7D;
    String lastUpdated;

    factory Coins.fromJson(Map<String, dynamic> json) => Coins(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        rank: json["rank"],
        priceUsd: json["price_usd"],
        priceBtc: json["price_btc"],
        the24HVolumeUsd: json["24h_volume_usd"],
        marketCapUsd: json["market_cap_usd"],
        availableSupply: json["available_supply"],
        totalSupply: json["total_supply"],
        maxSupply: json["max_supply"],
        percentChange1H: json["percent_change_1h"],
        percentChange24H: json["percent_change_24h"],
        percentChange7D: json["percent_change_7d"],
        lastUpdated: json["last_updated"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "rank": rank,
        "price_usd": priceUsd,
        "price_btc": priceBtc,
        "24h_volume_usd": the24HVolumeUsd,
        "market_cap_usd": marketCapUsd,
        "available_supply": availableSupply,
        "total_supply": totalSupply,
        "max_supply": maxSupply,
        "percent_change_1h": percentChange1H,
        "percent_change_24h": percentChange24H,
        "percent_change_7d": percentChange7D,
        "last_updated": lastUpdated,
    };
}
