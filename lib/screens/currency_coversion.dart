import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/currency_conversion/currency_selection.dart';
import './result.dart';
import '../components/currency_conversion/currency_rate.dart';
import 'package:flutter/cupertino.dart';

class Converter extends StatefulWidget {
  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  String fromCurrency = "THB";
  String toCurrency = "USD";
  final _formKey = GlobalKey<FormState>();
  TextEditingController _currencyControl = TextEditingController();

  void fromCurrencyChange(String newFromCurrency) {
    //Code Here
    setState(() {
      fromCurrency = newFromCurrency;
    });
  }

  void toCurrencyChange(String newToCurrency) {
    //Code Here
    setState(() {
      toCurrency = newToCurrency;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        //Form
        Form(
      key: _formKey,
      child: Column(
        children: [
          //TextFormField
          TextFormField(
            controller: _currencyControl,
            validator: (String inputNum) {
              if (inputNum.isEmpty) {
                return "Please input currency";
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.white),
            maxLengthEnforced: true,
            decoration: InputDecoration(
              hintText: "Enter Currency Conversion",
              hintStyle: TextStyle(color: Colors.white),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),

          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "From Currency:",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // From Currency Selection

          CurrencySelection(fromCurrency, fromCurrencyChange),

          SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "To Currency:",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // To Currency Selection
          CurrencySelection(toCurrency, toCurrencyChange),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              //Code Here
              if (_formKey.currentState.validate()) {
                final covertedValue = CurrencyExchangeRate.covertCurrency(
                    double.parse(_currencyControl.text),
                    fromCurrency,
                    toCurrency);

                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) {
                      return Result(double.parse(_currencyControl.text),
                          covertedValue, fromCurrency, toCurrency);
                    },
                  ),
                );
              }
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red[500],
              ),
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                "CONVERT !",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
