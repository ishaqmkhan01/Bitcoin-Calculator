// ignore_for_file: non_constant_identifier_names

class BtcTools {
  static double BtcToUsd(double btc, double futurerate) {
    if (btc < 0) {
      throw ArgumentError();
    }
    double ans = btc * futurerate;
    return ans;
  }

  static double UsdToBtc(double usd, double futurerate) {
    if (usd < 0) {
      throw ArgumentError();
    }
    double ans = 1 / futurerate;
    return ans * usd;
  }
}
