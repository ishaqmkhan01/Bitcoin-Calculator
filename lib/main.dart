import 'package:flutter/material.dart';
import 'usd_btc.dart';
import 'btc_usd.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter App',
      home: MyHomePage(key: Key('appTitle'), title: 'Currency Converter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please make a selection',
                style: TextStyle(fontSize: 18),
              ),
              FloatingActionButton.extended(
                key: Key('btc_to_usd'),
                label: Text('BTC To USD'),
                backgroundColor: Colors.white38,
                foregroundColor: Colors.black45,
                icon: Icon(
                  Icons.money,
                  size: 24.0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => btc_usd()),
                  );
                },
              ),
              Divider(
                height: 20,
                color: Colors.transparent,
              ),
              FloatingActionButton.extended(
                key: Key('usd_to_btc'),
                label: Text('USD To BTC'),
                backgroundColor: Colors.white38,
                foregroundColor: Colors.black45,
                icon: Icon(
                  // <-- Icon
                  Icons.monetization_on,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => usd_btc()),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
