import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> primaryCurrenciesList = [
  'USD',
  'CAD',
  'EUR',
  'INR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCurrentPrice(String currency) async {
    const apiKey = '0D3FDC82-8C33-4B95-B779-B8CD172BD6EA';
    var currentPrice = '?';
    var url =
        'https://rest.coinapi.io/v1/exchangerate/BTC/$currency?apikey=$apiKey';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var btcData = jsonDecode(response.body);
      currentPrice = btcData['rate'].round();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return currentPrice.toString();
  }
}
