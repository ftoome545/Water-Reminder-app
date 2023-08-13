import 'package:flutter/material.dart';

class ResponsiveContainer extends StatefulWidget {
  final Widget child;

  const ResponsiveContainer({Key? key, required this.child}) : super(key: key);

  @override
  _ResponsiveContainerState createState() => _ResponsiveContainerState();
}

class _ResponsiveContainerState extends State<ResponsiveContainer> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double containerWidth = screenSize.width * 0.9;

    return Container(
      width: containerWidth,
      alignment: Alignment.center,
      child: widget.child,
    );
  }
}
