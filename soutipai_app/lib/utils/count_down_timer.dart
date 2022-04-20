import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class CountDownWidgetWrapper extends StatefulWidget {
  final CountDownWidgetBuilder builder;
  final CountdownController controller;

  const CountDownWidgetWrapper(
      {Key? key, required this.builder, required this.controller})
      : super(key: key);

  @override
  _CountDownWidgetWrapperState createState() => _CountDownWidgetWrapperState();
}

class _CountDownWidgetWrapperState extends State<CountDownWidgetWrapper> {

  @override
  Widget build(BuildContext context) =>
      widget.builder.call(widget.controller.count);

  @override
  void dispose() {
    super.dispose();
    widget.controller.cancel();
  }
}

typedef CountDownWidgetBuilder = Widget Function(int count);

class CountdownController {
  final int startCount;

  final int endCount;

  int _countDown = 0;

  int get count => _countDown;

  late VoidCallback _countDownChanged;

  late Timer _timer;

  CountdownController(State state,{this.startCount = 60, this.endCount = 0}){
    _countDownChanged = ()=>state.setState((){});
    _timer = new Timer(const Duration(milliseconds: 1000), _countDownChanged);
  }

  void start() {
    _countDown = startCount;
    _countDownChanged.call();
    cancel();
    _timer = new Timer.periodic(
      Duration(seconds: 1),
          (Timer timer) {
        if (_countDown == endCount) {
          timer.cancel();
        } else {
          _countDown--;
        }
        _countDownChanged.call();
      },
    );
  }

  void cancel() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
  }
}