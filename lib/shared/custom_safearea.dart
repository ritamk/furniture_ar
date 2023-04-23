import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget {
  const CustomSafeArea({super.key, required this.child, this.color});
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Theme.of(context).primaryColor,
      child: SafeArea(child: child),
    );
  }
}
