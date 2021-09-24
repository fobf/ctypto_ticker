//2. Import the required packages.
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = '38F0CA98-604C-4985-997D-FDB06A0DDCB7';
const String coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate/';
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
  'UAH'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  //TODO 3: Update getCoinData to take the selectedCurrency as an input.
  Future getCoinData(selectedCurrency) async {
    //TODO 4: Update the URL to use the selectedCurrency input.
    var url = Uri.parse(coinApiUrl + 'BTC/$selectedCurrency?apikey=$apiKey');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var rate = jsonResponse['rate'];

      // var itemCount = jsonResponse['totalItems'];
      // print('Exchange rate: $rate');
      // print('Response body: ${response.body}');
      return rate;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
