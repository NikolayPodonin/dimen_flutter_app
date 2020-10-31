import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  double _numberFrom;
  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces'
  ];
  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7
  };
  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };


  String _startMeasure;
  String _convertedMeasure;
  String _resultMessage;

  final TextStyle _inputStile =
  TextStyle(fontSize: 20, color: Colors.blue[900]);
  final TextStyle _labelStile =
  TextStyle(fontSize: 24, color: Colors.grey[700]);

  @override
  Widget build(BuildContext context) {
    var appTitle = 'Measure Converter';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
          appBar: AppBar(
            title: Text(appTitle),
          ),
          body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                  child: Column(children: [
                    Spacer(),
                    Text(
                      'Value',
                      style: _labelStile,
                    ),
                    Spacer(),
                    TextField(
                        style: _inputStile,
                        decoration: InputDecoration(
                            hintText: 'Please insert the measure to be converted'),
                        onChanged: (text) {
                          var rv = double.tryParse(text);
                          if (rv != null) {
                            setState(() {
                              _numberFrom = rv;
                            });
                          }
                        }),
                    Spacer(),
                    Text(
                      'From',
                      style: _labelStile,
                    ),
                    Spacer(),
                    DropdownButton(
                        isExpanded: true,
                        value: _startMeasure,
                        items: _measures.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: _inputStile,
                            ),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          setState(() {
                            _startMeasure = value;
                          });
                        }),
                    Text(
                      'To',
                      style: _labelStile,
                    ),
                    DropdownButton(
                        isExpanded: true,
                        style: _inputStile,
                        value: _convertedMeasure,
                        items: _measures.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: _inputStile,
                            ),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          setState(() {
                            _convertedMeasure = value;
                          });
                        }),
                    Spacer(flex: 2),
                    RaisedButton(
                        child: Text(
                          'Convert',
                          style: _inputStile,
                        ),
                        onPressed: () {
                          if (_startMeasure.isEmpty || _convertedMeasure.isEmpty || _numberFrom==0) {
                            return; }
                          else {
                            _convert(_numberFrom, _startMeasure, _convertedMeasure);
                          }
                        }),
                    Spacer(flex: 2),
                    Text(
                      _resultMessage == null ? '' : _resultMessage.toString(),
                      style: _labelStile,
                    ),
                    Spacer(flex: 8),
                  ])))),
    );
  }

  @override
  void initState() {
    _numberFrom = 0;
    super.initState();
  }

  void _convert(double value, String from, String to) {
    int nFrom = _measuresMap[from];
    int nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;
    if (result == 0) {
      _resultMessage = 'This conversion cannot be performed';
    } else {
      _resultMessage = '${_numberFrom.toString()} $_startMeasure are ${result
          .toString()} $_convertedMeasure';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }
}
