import 'dart:math';

import 'package:flutter/material.dart';

class TweenPage extends StatefulWidget {
  const TweenPage({Key? key}) : super(key: key);

  @override
  State<TweenPage> createState() => _TweenPageState();
}

class _TweenPageState extends State<TweenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: SafeArea(
      //   child: Center(
      //     child: TweenAnimationBuilder<Color?>(
      //       tween: ColorTween(
      //         begin: Color.fromARGB(255, 156, 94, 32),
      //         end: Color(0xff000000),
      //       ),
      //       duration: const Duration(milliseconds: 10000),
      //       builder: (context, value, _) {
      //         print(value);
      //         return Container(
      //           height: 200.0,
      //           width: 200.0,
      //           color: value,
      //         );
      //       },
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TweenAnimationBuilder<double?>(
                  tween: Tween(begin: 1, end: 0),
                  duration: const Duration(milliseconds: 1200),
                  builder: (context, value, _) {
                    // print(value);
                    return Transform.translate(
                      offset: Offset(0, value! * 100),
                      child: const Text(
                        "Hola",
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                    );
                  },
                ),
                TweenAnimationBuilder<double?>(
                  tween: Tween(begin: 1, end: 0),
                  duration: const Duration(milliseconds: 1200),
                  builder: (context, value, _) {
                    // print(value);
                    return Transform.translate(
                      offset: Offset(-200 * value!, 0),
                      child: Container(
                        width: 200.0,
                        height: 200.0,
                        color: Colors.indigo,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TweenAnimationBuilder<double?>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 1200),
                  builder: (context, value, _) {
                    return Transform.rotate(
                      alignment: Alignment.topLeft,
                      angle: (25 / (180 / pi)) * value!,
                      child: Container(
                        width: 200.0,
                        height: 200.0,
                        color: Colors.redAccent,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 70.0,
                ),
                TweenAnimationBuilder<double?>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 1200),
                  builder: (context, value, _) {
                    print(value);
                    return Transform.scale(
                      scale: value! * 1,
                      child: Container(
                        width: 200.0,
                        height: 200.0,
                        color: Colors.purpleAccent,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
