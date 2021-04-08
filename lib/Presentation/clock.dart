import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock_painter.dart';

class Clock extends StatelessWidget {
  final DateTime time;
  final double width;
  final double height;

  const Clock({Key key,@required this.time,@required this.width,@required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterAnalogClock(
      dateTime: time,
      dialPlateColor: Colors.white,
      hourHandColor: Colors.red,
      minuteHandColor: Colors.redAccent,
      secondHandColor: Colors.black,
      numberColor: Colors.red,
      borderColor: Colors.black,
      tickColor: Colors.black,
      centerPointColor: Colors.black,
      showBorder: true,
      showTicks: true,
      showMinuteHand: true,
      showSecondHand: false,
      showNumber: true,
      borderWidth: 8.0,
      hourNumberScale: .8,
      hourNumbers: FlutterAnalogClockPainter.defaultHourNumbers,
      isLive: false,
      width: width,
      height: height,
      decoration: const BoxDecoration(),
    );
  }
}