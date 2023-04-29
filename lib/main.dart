import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  // Opeartion input

  String optInput = '';

  // Left Text Input
  String leftString = '0';
  // Right Text Input
  String rightString = '';
  // Selected Operation
  String selectedOpt = '';

  // Result

  double result = 0.0;

  bool error = false;

  // Operations Map

  List<String> ops = ['+', '*', '-', '/'];

  // Calculator number
  List<String> numbers = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.'
  ];

  // Operation Action : When User Clicked on any ops (+ , - , / , +)

  void handleCLickedOps(String ops) {
    setState(() {
      if (selectedOpt.length > 0) {
        switch (selectedOpt) {
          case '+':
            {
              result = double.parse(leftString) + double.parse(rightString);

              leftString = result.toString();
              rightString = '';
              selectedOpt = ops;
            }
            ;
          case '*':
            {
              result = double.parse(leftString) * double.parse(rightString);

              leftString = result.toString();
              rightString = '';
              selectedOpt = ops;
            }
            ;
          case '-':
            {
              result = double.parse(leftString) - double.parse(rightString);

              leftString = result.toString();
              rightString = '';
              selectedOpt = ops;
            }
            ;
          case '/':
            {
              if (rightString != '0') {
                result = double.parse(leftString) / double.parse(rightString);

                leftString = result.toString();
                rightString = '';
                selectedOpt = ops;
              } else {
                leftString = '0';
                rightString = '';
                selectedOpt = '';
                error = true;
                result = 0.0;
              }
            }
        }
      } else {
        selectedOpt = ops;
      }
    });
  }

  // Add Text To Text Input

  void writeEquation(String eq) {
    setState(() {
      error = false;
      if (selectedOpt.length < 1) {
        leftString += eq;
      } else {
        rightString += eq;
      }
    });
  }

  // Equal Action
  void equal() {
    setState(() {
      handleCLickedOps('');
      rightString = '';
      selectedOpt = '';
    });
  }

  // Redo writed text
  void redo() {
    setState(() {
      List<String> text = rightString.split("");
      text.removeLast();
      rightString = text.join();
    });
  }

  // Clear All

  void clear() {
    setState(() {
      leftString = '0';
      rightString = '';
      selectedOpt = '';
      result = 0.0;
    });
  }

  // ********* DONT FOCUS ON THE UI 😅 I JUST FOCUS ON THE LOGIC STUFFS 👆👆👆👆👆👆👆👆
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              width: double.infinity,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "$leftString $selectedOpt $rightString",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${error ? 'Error' : result}",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        clear();
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: double.infinity,
                          decoration: BoxDecoration(color: Colors.blue),
                          child: Text('C')),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      redo();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: double.infinity,
                        width: 200,
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Icon(Icons.more_outlined)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          equal();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: double.infinity,
                          width: 60,
                          decoration: BoxDecoration(color: Colors.blue),
                          child: Text("="),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5),
                  itemCount: numbers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        writeEquation(numbers[index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        child: Text(numbers[index]),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5),
                  itemCount: ops.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        handleCLickedOps(ops[index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        child: Text(ops[index]),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ))
          ],
        ),
      )),
    );
  }
}
