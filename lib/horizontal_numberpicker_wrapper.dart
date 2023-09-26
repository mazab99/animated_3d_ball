import 'package:flutter/material.dart';
import 'horizontal_numberpicker.dart';

class HorizontalNumberPickerWrapper extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final int step;
  final String unit;

  final int widgetWidth;

  final int subGridCountPerGrid;

  final int subGridWidth;

  final void Function(int) onSelectedChanged;

  String Function(int)? titleTransformer;

  final String Function(int)? scaleTransformer;

  final Color titleTextColor;

  final Color scaleColor;

  final Color indicatorColor;

  final Color scaleTextColor;

  HorizontalNumberPickerWrapper({
    Key? key,
    this.initialValue = 500,
    this.minValue = 100,
    this.maxValue = 900,
    this.step = 1,
    this.unit = "",
    this.widgetWidth = 200,
    this.subGridCountPerGrid = 10,
    this.subGridWidth = 8,
    required this.onSelectedChanged,
    this.titleTransformer,
    this.scaleTransformer,
    this.titleTextColor = const Color(0xFF3995FF),
    this.scaleColor = const Color(0xFFE9E9E9),
    this.indicatorColor = const Color(0xFF3995FF),
    this.scaleTextColor = const Color(0xFF8E99A0),
  }) : super(key: key) {
    titleTransformer ??= (value) {
      return value.toString();
    };
  }

  @override
  State<StatefulWidget> createState() {
    return HorizontalNumberPickerWrapperState();
  }
}

class HorizontalNumberPickerWrapperState
    extends State<HorizontalNumberPickerWrapper> {
  late int _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(HorizontalNumberPickerWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    int numberPickerHeight = 60;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Text(
              widget.titleTransformer!(_selectedValue),
              style: TextStyle(
                color: widget.titleTextColor,
                fontSize: 40,
              ),
            ),
            Text(
              ' ${widget.unit}',
              style: TextStyle(
                color: widget.titleTextColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(width: 0, height: 10),
        Stack(
          children: <Widget>[
            HorizontalNumberPicker(
              initialValue: widget.initialValue,
              minValue: widget.minValue,
              maxValue: widget.maxValue,
              step: widget.step,
              widgetWidth: widget.widgetWidth,
              widgetHeight: numberPickerHeight,
              subGridCountPerGrid: widget.subGridCountPerGrid,
              subGridWidth: widget.subGridWidth,
              onSelectedChanged: (value) {
                widget.onSelectedChanged(value);
                setState(() {
                  _selectedValue = value;
                });
              },
              scaleTransformer: widget.scaleTransformer,
              scaleColor: widget.scaleColor,
              indicatorColor: widget.indicatorColor,
              scaleTextColor: widget.scaleTextColor,
            ),
            Positioned(
              left: 0,
              child: Container(
                width: 20,
                height: numberPickerHeight.toDouble(),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.8),
                      Colors.white.withOpacity(0)
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                width: 20,
                height: numberPickerHeight.toDouble(),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(0.8)
                  ]),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
