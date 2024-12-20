import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text("Calculator")),
            body: const Calculator()));
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  int _result = 0;

  void _updateResult(result) {
    setState(() {
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  color: Colors.red,
                  child: Center(
                      child: Text('$_result',
                          style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 28, 214, 77))))),
              Factorial(
                // Pass callback
                _updateResult,
              ),
              Power(
                _updateResult,
              )
            ]));
  }
}

class Factorial extends StatefulWidget {
  final Function update;
  const Factorial(this.update, {Key? key}) : super(key: key);

  @override
  FactorialState createState() => FactorialState();
}

class FactorialState extends State<Factorial> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TextField(
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.w500, color: Colors.blue),
          controller: myController),
      TextButton(
          style: buttonStyle,
          onPressed: () {
            widget.update(factorial(int.parse(myController.text)));
            myController.clear();
          },
          child: const Text("FACTORIAL"))
    ]);
  }
}

var buttonStyle = TextButton.styleFrom(
    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
    backgroundColor: Colors.greenAccent);

int factorial(n) {
  if (n == 0) return 1;
  return n * factorial(n - 1);
}

int power(a, b) {
  if (b == 0) return 1;
  return a * power(a, b - 1);
}

class Power extends StatefulWidget {
  final Function update;
  const Power(this.update, {Key? key}) : super(key: key);

  @override
  PowerState createState() => PowerState();
}

class PowerState extends State<Power> {
  final baseController = TextEditingController();
  final expController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: 100,
                child: TextField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue),
                  controller: baseController,
                )),
            const Text("^"),
            SizedBox(
                width: 100,
                child: TextField(
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),
                    controller: expController)),
          ]),
      TextButton(
          style: buttonStyle,
          onPressed: () {
            // Widget is the a reference of the object StatefulWidget
            // of this state
            widget.update(power(
                int.parse(baseController.text), int.parse(expController.text)));
            baseController.clear();
            expController.clear();
          },
          child: const Text("POWER"))
    ]);
  }
}
