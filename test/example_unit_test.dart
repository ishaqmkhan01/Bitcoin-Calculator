import 'package:bitcoin_calculator/CurrencyAPI.dart';
import 'package:test/test.dart';
import 'package:bitcoin_calculator/btc_tools.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  group("http", () {
    test('returns a String if the http call completes successfully', () async {
      final client = MockClient();
      final fakeRateAPIData =
          '{"time":{"updated":"Nov 6, 2022 21:16:00 UTC","updatedISO":"2022-11-06T21:16:00+00:00","updateduk":"Nov 6, 2022 at 21:16 GMT"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"21,195.0737","description":"United States Dollar","rate_float":21195.0737}}}';

      var url =
          Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');

      when(client.get(url))
          .thenAnswer((_) async => http.Response(fakeRateAPIData, 200));

      double rate = await CurrencyAPI.fetchRate(client);

      expect(rate, isA<double>());

      expect(rate, 21195.0737);
    });

    test('throws an Exception if the http call fails', () async {
      final client = MockClient();
      var url =
          Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');

      when(client.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(CurrencyAPI.fetchRate(client), throwsException);
    });
  });

  group("btcTOusdConversion", () {
    final client = MockClient();
    final fakeRateAPIData =
        '{"time":{"updated":"Nov 6, 2022 21:16:00 UTC","updatedISO":"2022-11-06T21:16:00+00:00","updateduk":"Nov 6, 2022 at 21:16 GMT"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"21,195.0737","description":"United States Dollar","rate_float":21195.0737}}}';

    var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');

    when(client.get(url))
        .thenAnswer((_) async => http.Response(fakeRateAPIData, 200));
    test('1 USD to BTC', () async {
      double rate = await CurrencyAPI.fetchRate(client);
      double ans = BtcTools.UsdToBtc(1.0, rate);
      expect(ans, 0.00004718077484203322);
    });
    test('UsdToBtc on zero', () async {
      double rate = await CurrencyAPI.fetchRate(client);
      double ans = BtcTools.UsdToBtc(0.0, rate);
      expect(ans, 0);
    });
    test('UsdToBtc throws ArgumentError on negative number', () async {
      double rate = await CurrencyAPI.fetchRate(client);
      expect(() => BtcTools.UsdToBtc(-0.1, rate), throwsArgumentError);
    });
  });

  group("btcTOusdConversion", () {
    final client = MockClient();
    final fakeRateAPIData =
        '{"time":{"updated":"Nov 6, 2022 21:16:00 UTC","updatedISO":"2022-11-06T21:16:00+00:00","updateduk":"Nov 6, 2022 at 21:16 GMT"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"21,195.0737","description":"United States Dollar","rate_float":21195.0737}}}';

    var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');

    when(client.get(url))
        .thenAnswer((_) async => http.Response(fakeRateAPIData, 200));

    test('1 BTC to USD ', () async {
      double rate = await CurrencyAPI.fetchRate(client);
      double ans = BtcTools.BtcToUsd(1.0, rate);
      expect(ans, 21195.0737);
    });
    test('BtcToUsd throws ArgumentError on zero', () async {
      double rate = await CurrencyAPI.fetchRate(client);
      double ans = BtcTools.BtcToUsd(0.0, rate);
      expect(ans, 0);
    });
    test('BtcToUsd throws ArgumentError on negative number', () async {
      double rate = await CurrencyAPI.fetchRate(client);
      expect(() => BtcTools.BtcToUsd(-0.1, rate), throwsArgumentError);
    });
  });
}
