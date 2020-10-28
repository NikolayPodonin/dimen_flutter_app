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
  String _startMeasure;
  String _convertedMeasure;

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
                    onPressed: () => true),
                Spacer(flex: 2),
                Text(
                  _numberFrom == null ? '' : _numberFrom.toString(),
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
}
