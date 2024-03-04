import 'package:flutter/material.dart';
import 'package:multi_wheel_number/multi_wheel_number.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _number = 90;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example MultiWheel Number'),
      ),
      body: Center(
        child: MultiWheelNumber(itemExtent: 35, fontSize: 25, number: _number),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text('+5'),
        onPressed: () {
          _number += 5;
          setState(() {});
        },
      ),
    );
  }
}
