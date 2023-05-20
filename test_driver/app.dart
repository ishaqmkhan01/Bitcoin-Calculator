import 'package:flutter_driver/driver_extension.dart';
import 'package:bitcoin_calculator/main.dart' as app;
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:bitcoin_calculator/config/globals.dart' as globals;

class MockClient extends Mock implements http.Client {}

void main() {
  enableFlutterDriverExtension();

  final client = MockClient();
  final fakeRateAPIData =
      '{"time":{"updated":"Nov 6, 2022 21:16:00 UTC","updatedISO":"2022-11-06T21:16:00+00:00","updateduk":"Nov 6, 2022 at 21:16 GMT"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"21,195.0737","description":"United States Dollar","rate_float":21195.0737}}}';
  var url = Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');

  when(client.get(url)).thenAnswer(
      (realInvocation) async => http.Response(fakeRateAPIData, 200));

  globals.httpClient = client;

  app.main();
}
