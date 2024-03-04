import 'package:flutter/material.dart';

import 'dart:math';

/// Create a Multi-Wheel-Number-Display that control the state (number).
///
/// It requires the [fontSize], [ItemExtend] and the [number] to show, the rest of the params are opcional.
class MultiWheelNumber extends StatefulWidget {
  final int number;
  final TextStyle? textStyle;
  final double fontSize;
  final int? figures;
  final double itemExtent;
  final Curve curve;
  final Duration? duration;
  final double spacingBetweenNumbers;

  const MultiWheelNumber({
    super.key,
    this.textStyle,
    this.figures,
    required this.itemExtent,
    this.curve = Curves.ease,
    this.duration,
    required this.fontSize,
    this.spacingBetweenNumbers = 0.35,
    required this.number,
  }) : assert(spacingBetweenNumbers < 1 && spacingBetweenNumbers > 0);

  @override
  State<MultiWheelNumber> createState() => _MultiWheelNumberState();
}

class _MultiWheelNumberState extends State<MultiWheelNumber> {
  List<ScrollController> scrollControllerList = [];
  late List<Widget> numberList;
  late int numberToShow;
  late int figuresToShow;
  late Duration duration;

  /// Clean the ScrollControllers to free the memory
  @override
  void dispose() {
    super.dispose();
    scrollControllerList.map((e) => e.dispose());
  }

  /// Calculate the initial data
  ///
  /// * [numberToShow] is the number the widget go to show in UI.
  /// * [figuresToShow] is the amount of figures the widget need to show, it can be fix or variable.
  /// Create all the Text-Widget to create every [ListWheelScrollView], set a TextStyle if a [textStyle] is given.
  /// Create the scrollControllerList to manage all the scrolls animations.
  /// Wait the UI building (with a [Future.delay] and show the number scrolling the wheels
  @override
  void initState() {
    super.initState();
    numberToShow = widget.number;
    figuresToShow = widget.figures ?? getFiguresFrom(numberToShow);
    duration = widget.duration ?? const Duration(milliseconds: 900);

    numberList = List.generate(
      10,
      (index) => Text(
        index.toString(),
        style: widget.textStyle != null
            ? widget.textStyle!.copyWith(fontSize: widget.fontSize)
            : TextStyle(fontSize: widget.fontSize),
      ),
    ).toList();

    List.generate(
      figuresToShow,
      (index) => scrollControllerList.add(ScrollController()),
    );
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        setNumber();
      },
    );
  }

  /// Split the work to all wheels
  setNumber() {
    int divider = 10;
    for (int i = 0; i < figuresToShow; i++) {
      setSingleNumber(pow(divider, (i + 1)).toInt(), figuresToShow - 1 - i);
    }
  }

  /// Calculate the distance the widget have to scroll and animate the scroll movement
  setSingleNumber(int divider, int index) {
    double distance =
        ((widget.number % divider) ~/ (divider / 10)) * widget.itemExtent;
    if (scrollControllerList[index].hasClients) {
      scrollControllerList[index]
          .animateTo(distance, curve: widget.curve, duration: duration);
    }
  }

  /// Calculate the number of figures should be showed when the [numbertoShow] change
  @override
  void didUpdateWidget(covariant MultiWheelNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
    while (figuresToShow < (widget.figures ?? getFiguresFrom(widget.number))) {
      scrollControllerList.add(ScrollController());
      figuresToShow++;
    }
    while (figuresToShow > (widget.figures ?? getFiguresFrom(widget.number))) {
      scrollControllerList.first.dispose();
      scrollControllerList.removeAt(0);
      figuresToShow--;
    }
  }

  /// Build the list of wheels depends on [figuresToShow] and set the new Number.
  @override
  Widget build(BuildContext context) {
    Future(() {
      setNumber();
    });
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
          figuresToShow,
          (index) => SingleNumber(
              controller: scrollControllerList[index],
              fontSize: widget.fontSize,
              lista: numberList,
              itemExtent: widget.itemExtent,
              spacingBetweenNumbers: widget.spacingBetweenNumbers)),
    );
  }

  /// Get the [figuresToShow] by number.
  ///
  /// if [number] = 0, then return 1.
  getFiguresFrom(int number) {
    int figures = 0;
    int currentNumber = number;
    while (currentNumber > 0) {
      figures++;
      currentNumber = currentNumber ~/ 10;
    }
    if (figures > 0) {
      return figures;
    } else {
      return 1;
    }
  }
}

/// A [StatelessWidget] that manages one wheel of the Row and the space between them.
class SingleNumber extends StatelessWidget {
  const SingleNumber({
    super.key,
    required this.fontSize,
    required this.lista,
    required this.itemExtent,
    required this.spacingBetweenNumbers,
    required this.controller,
  });

  final double fontSize;
  final double itemExtent;
  final ScrollController controller;
  final double spacingBetweenNumbers;
  final List<Widget> lista;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: fontSize + 2,
        width: fontSize - fontSize * spacingBetweenNumbers,
        child: ListWheelScrollView.useDelegate(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            itemExtent: itemExtent,
            childDelegate: ListWheelChildLoopingListDelegate(children: lista)));
  }
}
