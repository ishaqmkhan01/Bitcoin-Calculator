import 'package:http/http.dart' as http;
import 'dart:convert';

double value;

class CurrencyAPI {
  static Future<double> fetchRate(http.Client client) async {
    var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      value = json["bpi"]["USD"]["rate_float"];

      return json["bpi"]["USD"]["rate_float"];
    } else {
      throw Exception('Failed to load rate');
    }
  }
}
