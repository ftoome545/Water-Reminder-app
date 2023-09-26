import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = new Path();
    path.lineTo(0, size.height);
    //P0 first point of quadratic bezier cruve
    var firstStart = Offset(size.width / 5, size.height);
    //P1 second point of quadratic bezier cruve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    //second starting point
    //P3 third point of quadratic bezier cruve
    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //P4 fourth point of quadratic bezier cruve
    var secondEnd = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    //end with this path if you are making wave
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
