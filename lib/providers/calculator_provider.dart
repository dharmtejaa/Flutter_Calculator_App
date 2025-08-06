import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorProvider with ChangeNotifier {
  String _userInput = '';
  String _result = '';

  String get userInput => _userInput;
  String get result => _result;

  /// Adds a number to the user input
  void addNumber(String number) {
    _userInput += number;
    notifyListeners();
  }

  /// Adds an operator to the user input
  void addOperator(String operator) {
    if (isOperatorAllowed(_userInput)) {
      return;
    }
    _userInput += operator;
    notifyListeners();
  }

  /// Adds a decimal point to the user input
  void addDecimal() {
    if (_userInput.isEmpty || RegExp(r'[\^/x\-\+%]$').hasMatch(_userInput)) {
      _userInput += '0.';
    } else if (!RegExp(r'\d+\.\d*$').hasMatch(_userInput)) {
      _userInput += '.';
    }
    notifyListeners();
  }

  /// Clears all input and result
  void clearAll() {
    _userInput = '';
    _result = '';
    notifyListeners();
  }

  /// Deletes the last character from user input
  void deleteLast() {
    _result = '';
    if (_userInput.isNotEmpty) {
      _userInput = _userInput.substring(0, _userInput.length - 1);
    }
    if (isOperatorAllowed(_userInput)) {
      return;
    }
    notifyListeners();
  }

  /// Evaluates the mathematical expression
  void evaluate() {
    try {
      String finalInput = _userInput.replaceAll('x', '*');
      // ignore: deprecated_member_use
      Expression expression = Parser().parse(finalInput);
      ContextModel contextModel = ContextModel();
      double evalResult = expression.evaluate(
        EvaluationType.REAL,
        contextModel,
      );
      _result =
          evalResult == evalResult.toInt()
              ? evalResult.toInt().toString()
              : evalResult.toStringAsFixed(6);
    } catch (e) {
      _result = 'Invalid Expression';
    }
    notifyListeners();
  }

  /// Checks if an operator is allowed at the end of the expression
  bool isOperatorAllowed(String input) {
    return input.isEmpty ||
        RegExp(r'[\^/x\-\+%\.]').hasMatch(input[input.length - 1]);
  }
}
