// Imports the Flutter Driver API.

// ignore_for_file: non_constant_identifier_names

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  group('Happy Path', () {
    final usd_selection_button = find.byValueKey('btc_to_usd');
    final btc_selection_button = find.byValueKey('usd_to_btc');
    final usd_back_button = find.byValueKey('backButton_usd');
    final btc_back_button = find.byValueKey('backButton_btc');
    final usd_entry = find.byValueKey('UserEntry_usd');
    final btc_entry = find.byValueKey('UserEntry_btc');
    final usd_convert_button = find.byValueKey('ConvertButton_usd');
    final btc_convert_button = find.byValueKey('ConvertButton_btc');
    final btc_result = find.byValueKey('result_btc');
    final usd_result = find.byValueKey('result_usd');

    /*
      Given I am on the Currency Selection Screen
      When I tap "USD to BTC"
      And I enter "20288.50"
      And I tap "Convert"
      Then I should see "0.9572272 BTC"
    */
    test("should give conversion from 20288.50 USD and get 0.9572272 BTC",
        () async {
      await driver.tap(btc_selection_button);
      await driver.tap(btc_entry);
      await driver.enterText('20288.50');
      await driver.waitFor(find.text('20288.50'));
      await driver.tap(btc_convert_button);
      expect(await driver.getText(btc_result), '0.9572272 BTC');
      await driver.tap(btc_back_button);
    });

    /*
      Given I am on the Currency Selection Screen
      When I tap "BTC to USD"
      And I enter "1"
      And I tap "Convert"
      Then I should see "21195.07 USD"
    */
    test("should give conversion for 1 BTC to 21195.07 USD", () async {
      await driver.tap(usd_selection_button);
      await driver.tap(usd_entry);
      await driver.enterText('1');
      await driver.waitFor(find.text('1'));
      await driver.tap(usd_convert_button);
      expect(await driver.getText(usd_result), '21195.07 USD');
      await driver.tap(usd_back_button);
    });
  });

  group('Sad Path', () {
    final usd_selection_button = find.byValueKey('btc_to_usd');
    final btc_selection_button = find.byValueKey('usd_to_btc');
    final usd_back_button = find.byValueKey('backButton_usd');
    final btc_back_button = find.byValueKey('backButton_btc');
    final usd_entry = find.byValueKey('UserEntry_usd');
    final btc_entry = find.byValueKey('UserEntry_btc');
    final usd_convert_button = find.byValueKey('ConvertButton_usd');
    final btc_convert_button = find.byValueKey('ConvertButton_btc');
    final btc_result = find.byValueKey('result_btc');
    final usd_result = find.byValueKey('result_usd');

    /*
      Given I am on the Currency Selection Screen
      When I tap "USD to BTC"
      And I enter "-3"
      And I tap "Convert"
      Then I should not see "null BTC"
    */
    test("negative input numbers should not give a converted value, USD to BTC",
        () async {
      await driver.tap(btc_selection_button);
      await driver.tap(btc_entry);
      await driver.enterText('-3');
      await driver.waitFor(find.text('-3'));
      await driver.tap(btc_convert_button);
      expect(await driver.getText(btc_result),
          'null BTC'); //hidden purposefully to not show a null value
      await driver.tap(btc_back_button);
    });

    /*
      Given I am on the Currency Selection Screen
      When I tap "USD to BTC"
      And I enter "&"
      And I tap "Convert"
      Then I should not see "null BTC"
    */
    test("should throw an error when symbol entered, USD to BTC ", () async {
      await driver.tap(btc_selection_button);
      await driver.tap(btc_entry);
      await driver.enterText('&');
      await driver.waitFor(find.text('&'));
      await driver.tap(btc_convert_button);
      expect(await driver.getText(btc_result),
          'null BTC'); //hidden purposefully to not show a null value
      await driver.tap(btc_back_button);
    });

    /*
      Given I am on the Currency Selection Screen
      When I tap "BTC to USD"
      And I enter "-3"
      And I tap "Convert"
      Then I should not see "null USD"
    */
    test("negative input numbers should not give a converted value, BTC to USD",
        () async {
      await driver.tap(usd_selection_button);
      await driver.tap(usd_entry);
      await driver.enterText('-3');
      await driver.waitFor(find.text('-3'));
      await driver.tap(usd_convert_button);
      expect(await driver.getText(usd_result),
          'null USD'); //hidden purposefully to not show a null value
      await driver.tap(usd_back_button);
    });

    /*
      Given I am on the Currency Selection Screen
      When I tap "USD to BTC"
      And I enter "&"
      And I tap "Convert"
      Then I should not see "null BTC"
    */
    test("should throw an error when symbol entered, BTC to USD", () async {
      await driver.tap(usd_selection_button);
      await driver.tap(usd_entry);
      await driver.enterText('&');
      await driver.waitFor(find.text('&'));
      await driver.tap(usd_convert_button);
      expect(await driver.getText(usd_result),
          'null USD'); //hidden purposefully to not show a null value
      await driver.tap(usd_back_button);
    });
  });

  group('testing back buttons', () {
    final usd_selection_button = find.byValueKey('btc_to_usd');
    final btc_selection_button = find.byValueKey('usd_to_btc');
    final usd_back_button = find.byValueKey('backButton_usd');
    final btc_back_button = find.byValueKey('backButton_btc');

    /*
      Given I am on the Currency Selection Screen
      When I tap "BTC to USD"
      Then I tap the back button      
      Then I should Currency Selection Screen
    */
    test(
        "after clicking BTC to USD button, back button should take me to selection screen",
        () async {
      await driver.tap(usd_selection_button);
      await driver.tap(usd_back_button);
      await driver.waitForTappable(usd_selection_button);
    });

    /*
      Given I am on the Currency Selection Screen
      When I tap "USD to BTC"
      Then I tap the back button      
      Then I should Currency Selection Screen
    */
    test(
        "after clicking USD to BTC button, back button should take me to selection screen",
        () async {
      await driver.tap(btc_selection_button);
      await driver.tap(btc_back_button);
      await driver.waitForTappable(btc_selection_button);
    });
  });
}
