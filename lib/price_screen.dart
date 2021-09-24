import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  //TODO 6: Update the default currency to AUD, the first item in the currencyList.
  String? selectedCurrency = 'AUD';

  @override
  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  List<Text> getPickerItems() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(
        Text(
          currency,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      );
    }
    return pickerItems;
  }

  String bitcoinValueInUsd = '?';

  void getData() async {
    try {
      double rate = await CoinData().getCoinData(selectedCurrency);
      setState(() {
        bitcoinValueInUsd = rate.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('🤑 Coin Ticker'),
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
                  //TODO 5: Update the currency name depending on the selectedCurrency.
                  '1 BTC = $bitcoinValueInUsd $selectedCurrency',
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
            child: CupertinoPicker(
              backgroundColor: Colors.lightBlue,
              itemExtent: 32,
              onSelectedItemChanged: (selectedIndex) {
                setState(() {
                  selectedCurrency = currenciesList[selectedIndex];
                  getData();
                  // print(selectedIndex);
                });

                //TODO 1: Save the selected currency to the property selectedCurrency
                //TODO 2: Call getData() when the picker/dropdown changes.

                //TODO 2: Call getData() when the picker/dropdown changes.
                //ADD in setState
              },
              children: getPickerItems(),
            ),
          ),
        ],
      ),
    );
  }
}

// DropdownButton<String>(
//               value: selectedCurrency,
//               items: getDropdownItems(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedCurrency = value;
