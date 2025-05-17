import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  double height = 150.0;
  int age = 18;
  double weight = 50.0;
  var sli = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("BMi calculator"),
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: 150,
                  height: 190,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(136, 68, 137, 255)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.male,
                        size: 60,
                        color: Colors.white,
                      ),
                      Text("Male",
                          style: TextStyle(fontSize: 23, color: Colors.white)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 150,
                  height: 190,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(136, 68, 137, 255)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.female,
                        size: 60,
                        color: Colors.white,
                      ),
                      Text("Female",
                          style: TextStyle(fontSize: 23, color: Colors.white)),
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: 320,
              height: 190,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(136, 68, 137, 255)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Height",
                      style: TextStyle(fontSize: 22, color: Colors.white)),
                  Text("150.0",
                      style: TextStyle(fontSize: 19, color: Colors.white)),
                  Slider(
                      activeColor: const Color.fromARGB(168, 230, 105, 103),
                      min: 0,
                      max: 100,
                      value: sli,
                      onChanged: (val) {
                        setState(() {
                          sli = val;
                        });
                      }),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: 150,
                  height: 190,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(136, 68, 137, 255)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Age",
                          style: TextStyle(fontSize: 23, color: Colors.white)),
                      Text("18",
                          style: TextStyle(fontSize: 23, color: Colors.white)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color.fromARGB(168, 230, 105, 103)),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color.fromARGB(168, 230, 105, 103)),
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 150,
                  height: 190,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(136, 68, 137, 255)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Weight",
                          style: TextStyle(fontSize: 23, color: Colors.white)),
                      Text("50",
                          style: TextStyle(fontSize: 23, color: Colors.white)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color.fromARGB(168, 230, 105, 103)),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color.fromARGB(168, 230, 105, 103)),
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(2),
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(168, 230, 105, 103)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("CALCULATE",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
            ),
          ],
        )));
  }
}
