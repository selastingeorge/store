import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DoubleBackExit extends StatefulWidget {
  final Widget child;

  const DoubleBackExit({super.key, required this.child});

  @override
  State<DoubleBackExit> createState() => _DoubleBackExitState();
}

class _DoubleBackExitState extends State<DoubleBackExit> {
  DateTime? lastPressed;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        if (lastPressed == null || DateTime.now().difference(lastPressed!) > Duration(seconds: 2)) {
          lastPressed = DateTime.now();
          Fluttertoast.showToast(msg: 'Press back again to exit', toastLength: Toast.LENGTH_LONG);
        } else {
          SystemNavigator.pop();
        }
      },
      child: widget.child,
    );
  }
}
