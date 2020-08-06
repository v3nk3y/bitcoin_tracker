import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var selectedCurrency = 'USD';
  String currentPrice = '?';
  CoinData coinData = CoinData();

  DropdownButton<String> androidDropDownButton() {
    List<DropdownMenuItem<String>> dropDownList = [];

    for (String currency in primaryCurrenciesList) {
      dropDownList.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownList,
      onChanged: (value) async {
        String latestPrice = await coinData.getCurrentPrice(value);
        setState(() {
          selectedCurrency = value;
          currentPrice = latestPrice;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerList = [];

    for (String currency in primaryCurrenciesList) {
      pickerList.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (selectedIndex) async {
        print(selectedIndex);
        String latestPrice = await coinData
            .getCurrentPrice(primaryCurrenciesList[selectedIndex]);
        setState(() {
          currentPrice = latestPrice;
          selectedCurrency = primaryCurrenciesList[selectedIndex];
        });
      },
      children: pickerList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $currentPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDownButton(),
          ),
        ],
      ),
    );
  }
}
