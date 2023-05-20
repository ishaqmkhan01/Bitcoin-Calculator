// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:bitcoin_calculator/CurrencyAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'btc_tools.dart';
import 'config/globals.dart';

class btc_usd extends StatefulWidget {
  @override
  _btc_usdState createState() => _btc_usdState();
}

class _btc_usdState extends State<btc_usd> {
  TextEditingController UserInput = TextEditingController();
  double UserInputinNumber;
  String USD;
  bool visible = false;
  bool showError = false;
  String guessTextFieldErrorMessage = '';

  Future<double> futurerate;
  double btcrate;

  @override
  void initState() {
    super.initState();
    futurerate = CurrencyAPI.fetchRate(httpClient);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            key: Key('backButton_usd'),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          iconTheme: IconThemeData(
            color: Color(0xff4c748b),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color(0xFFF3F3F3),
        body: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              FutureBuilder<double>(
                  future: futurerate,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      btcrate = value;
                      return Text("");
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  }),
              SizedBox(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.5,
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: SizedBox(
                      width: 340,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: visible,
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            child: Text("$USD" + ' USD',
                                key: Key('result_usd'),
                                style: TextStyle(
                                  fontFamily: "Kollektif",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF4C748B),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  child: Center(
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.5,
                          color: Color(0xFF4C748B),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 340,
                      height: 50,
                      child: TextFormField(
                        key: Key('UserEntry_usd'),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          errorText:
                              showError ? guessTextFieldErrorMessage : null,
                          hintText: "Enter BTC amount",
                        ),
                        keyboardType: TextInputType.number,
                        controller: UserInput,
                      ),
                    )),
              )),
              Padding(padding: EdgeInsets.all(4)),
              SizedBox(
                  width: 280,
                  height: 45,
                  child: ElevatedButton(
                    key: Key("ConvertButton_usd"),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF4C748B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                      elevation: 0.0,
                    ),
                    onPressed: () {
                      USD = UserInput.text;
                      setState(() {
                        visible = false;
                        try {
                          visible = true;
                          USD = BtcTools.BtcToUsd(
                                  double.parse(UserInput.text), value)
                              .toStringAsFixed(2);
                          showError = false;
                        } catch (e) {
                          USD = null;
                          guessTextFieldErrorMessage =
                              'Invalid input, must be a number';
                          showError = true;
                          visible = false;
                        }
                      });
                    },
                    child: Text(
                      "Convert",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Montserrat",
                        color: Color(0xFFFFFFFF),
                        backgroundColor: Color(0x4C748B),
                      ),
                    ),
                  ))
            ])));
  }
}
