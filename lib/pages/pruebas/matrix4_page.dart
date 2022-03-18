import 'package:flutter/material.dart';

class Matrix4Page extends StatefulWidget {
  const Matrix4Page({Key? key}) : super(key: key);

  @override
  State<Matrix4Page> createState() => _Matrix4PageState();
}

class _Matrix4PageState extends State<Matrix4Page> {
  double x = 0;
  double y = 0;
  double z = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform(
          transform: Matrix4(
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            1,
          )
            ..rotateX(x)
            ..rotateY(y)
            ..rotateZ(z),
          alignment: FractionalOffset.center,
          child: GestureDetector(
            onPanUpdate: (detail) {
              // print(detail.delta.dx);
              // print(detail.delta.dy);

              x = x + detail.delta.dx / 100;
              y = y - detail.delta.dx / 100;
              print(x);
              setState(() {});
            },
            child: Container(
              height: 200.0,
              width: 200.0,
              color: Colors.indigo,
            ),
          ),
        ),
      ),
    );
  }
}
