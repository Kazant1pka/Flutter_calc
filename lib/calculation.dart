import 'package:calc/calc_button.dart';
import 'package:flutter/material.dart';
import './result_display.dart';

class Calculation extends StatefulWidget {
  const Calculation({super.key});

  @override
  State<Calculation> createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  double width = 0;

  int? firstOperand;
  String? operator;
  int? secondOperand;
  int? result;

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ResultDisplay(text: _getDisplayText()),
        Row(children: [
          _getButton(text: '7', onTap: () => numberPressed(7)),
          _getButton(text: '8', onTap: () => numberPressed(8)),
          _getButton(text: '9', onTap: () => numberPressed(9)),
          _getButton(
              text: '*',
              onTap: () => operatorPressed('*'),
              backgroundColor: const Color.fromRGBO(220, 220, 220, 1)),
        ]),
        Row(children: [
          _getButton(text: '4', onTap: () => numberPressed(4)),
          _getButton(text: '5', onTap: () => numberPressed(5)),
          _getButton(text: '6', onTap: () => numberPressed(6)),
          _getButton(
              text: '/',
              onTap: () => operatorPressed('/'),
              backgroundColor: const Color.fromRGBO(220, 220, 220, 1)),
        ]),
        Row(children: [
          _getButton(text: '1', onTap: () => numberPressed(1)),
          _getButton(text: '2', onTap: () => numberPressed(2)),
          _getButton(text: '3', onTap: () => numberPressed(3)),
          _getButton(
              text: '+',
              onTap: () => operatorPressed('+'),
              backgroundColor: const Color.fromRGBO(220, 220, 220, 1)),
        ]),
        Row(children: [
          _getButton(
              text: '=',
              onTap: calculateResult,
              backgroundColor: Colors.orange,
              textColor: Colors.white),
          _getButton(text: '0', onTap: () => numberPressed(0)),
          _getButton(
              text: 'C',
              onTap: clear,
              backgroundColor: const Color.fromRGBO(220, 220, 220, 1)),
          _getButton(
              text: '-',
              onTap: () => operatorPressed('-'),
              backgroundColor: const Color.fromRGBO(220, 220, 220, 1)),
        ]),
      ],
    );
  }

  operatorPressed(String operator) {
    setState(() {
      if (firstOperand == null) {
        firstOperand = 0;
      }
      this.operator = operator;
    });
  }

  numberPressed(int number) {
    setState(() {
      if (result != null) {
        result = null;
        firstOperand = number;
        return;
      }
      if (firstOperand == null) {
        firstOperand = number;
        return;
      }
      if (operator == null) {
        firstOperand = int.parse('$firstOperand$number');
        return;
      }
      if (secondOperand == null) {
        secondOperand = number;
        return;
      }
      secondOperand = int.parse('$secondOperand$number');
    });
  }

  calculateResult() {
    if (operator == null || secondOperand == null) {
      return 'sad';
    }
    setState(() {
      switch (operator) {
        case '+':
          result = firstOperand! + secondOperand!;
          break;
        case '-':
          result = firstOperand! - secondOperand!;
          break;
        case '*':
          result = firstOperand! * secondOperand!;
          break;
        case '/':
          if (secondOperand == 0) {
            return;
          }
          result = firstOperand! ~/ secondOperand!;
          break;
      }
      firstOperand = result;
      operator = null;
      secondOperand = null;
      result = null;
    });
  }

  clear() {
    setState(() {
      firstOperand = null;
      operator = null;
      secondOperand = null;
      result = null;
    });
  }

  Widget _getButton(
      {required String text,
      required VoidCallback onTap,
      Color backgroundColor = Colors.white,
      Color textColor = Colors.black}) {
    return CalculatorButton(
      label: text,
      onTap: onTap,
      size: width / 4 - 12,
      backgroundColor: backgroundColor,
      labelColor: textColor,
    );
  }

  String _getDisplayText() {
    if (result != null) {
      return '$result';
    }
    if (secondOperand != null) {
      return '$firstOperand$operator$secondOperand';
    }
    if (operator != null) {
      return '$firstOperand$operator';
    }
    if (firstOperand != null) {
      return '$firstOperand';
    }
    return '0';
  }
}
