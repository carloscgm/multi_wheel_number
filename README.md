[![Star on GitHub](https://img.shields.io/github/stars/carloscgm/multi_wheel_number.svg?style=social&label=Star)](https://github.com/carloscgm/multi_wheel_number)


![Demo](https://raw.githubusercontent.com/carloscgm/multi_wheel_number/main/assets/demo.gif)

A widget that displays a number with a single wheel for each number, controlling the animations so that the number changes are smooth and user-friendly.


## Installing

1. Add this line to your package's `pubspec.yaml` file:
```yaml
dependencies:
  multi_wheel_number: ^0.0.1
```
2. Install packages from the command line
```dart
$ flutter pub get
```
3. Import it, now in your `Dart` code, you can use
```dart
import  'package:multi_wheel_number/multi_wheel_number.dart';
```


## Usage

`MultiWheelNumber` is a StatefulWidget that manage a Row of ListWheelScrollViews to show a number with this wheel-effect.

```dart
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
```

This widget needs:
- itemExtend of the wheels.
- the fontSize of the TextWidget of the wheels.
- the number to show.

>**Highly recommended**: Test some values of fontSize and itemExtend to get the effect you want. 

## Parameters

|                |                          |DESCRIPTION|
|----------------|-------------------------------|-----------------------------|
|number|`'required'`|Number to show|
|fontSize|`'required'`|The font size text of the wheels|
|itemExtent|`'required'`|the height item of the wheel|
|textStyle|`'optional'`|The TextStyle of the TextWidget|
|figures|`'optional'`|Fix the number of figures you want to show|
|curve|`'optional'`|The curve of the animation, by default: `Curves.ease`|
|duration|`'optional'`|The duration of the animation, by default: `const  Duration(milliseconds:  900)`|
|spacingBetweenNumbers|`'optional'`|The space between the wheels, fontSize and itemExtends can produce a unwanted space, fix it with this parameter, by default: `0.35`|


You can custom the widget as you wish with Text Style and wraping in a Container, some examples:
![Demo](https://raw.githubusercontent.com/carloscgm/multi_wheel_number/main/assets/examples.gif)