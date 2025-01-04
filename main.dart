import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  double _num1 = 0;
  double _num2 = 0;
  String _operation = '';
  bool _isNewInput = true;

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '0';
        _num1 = 0;
        _num2 = 0;
        _operation = '';
        _isNewInput = true;
      } else if (value == '+' || value == '-' || value == '×' || value == '÷') {
        _num1 = double.tryParse(_display) ?? 0;
        _operation = value;
        _isNewInput = true;
      } else if (value == '=') {
        _num2 = double.tryParse(_display) ?? 0;
        switch (_operation) {
          case '+':
            _display = (_num1 + _num2).toString();
            break;
          case '-':
            _display = (_num1 - _num2).toString();
            break;
          case '×':
            _display = (_num1 * _num2).toString();
            break;
          case '÷':
            if (_num2 != 0) {
              _display = (_num1 / _num2).toString();
            } else {
              _display = 'Error';
            }
            break;
          default:
            break;
        }
        _operation = '';
        _isNewInput = true;
      } else {
        if (_isNewInput) {
          _display = value;
          _isNewInput = false;
        } else {
          _display += value;
        }
      }
    });
  }

  Widget _buildButton(String value) {
    return ElevatedButton(
      onPressed: () => _buttonPressed(value),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20),
        textStyle: TextStyle(fontSize: 24),
      ),
      child: Text(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Display
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Text(
              _display,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          // Buttons
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('÷'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('×'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('-'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton('C'),
                    _buildButton('0'),
                    _buildButton('='),
                    _buildButton('+'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}