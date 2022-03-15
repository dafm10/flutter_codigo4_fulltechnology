import 'package:flutter/material.dart';

class AnimatedControllerPage extends StatefulWidget {
  const AnimatedControllerPage({Key? key}) : super(key: key);

  @override
  State<AnimatedControllerPage> createState() => _AnimatedControllerPageState();
}

class _AnimatedControllerPageState extends State<AnimatedControllerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pruebaController;
  late Animation _pruebaAnimation;

  late AnimationController _turnController;
  late Animation<double> _turnAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _pruebaController = AnimationController(
    //     vsync: this, duration: const Duration(milliseconds: 1200));
    // _pruebaAnimation = ColorTween(
    //   begin: Colors.black,
    //   end: Color(0xffE45646),
    // ).animate(_pruebaController);

    _turnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    // Quitamos el forward para que el reverse funcione
    _turnController.forward();
    _turnController.addListener(() {
      print(_turnController.value);
    });
    _turnAnimation = CurvedAnimation(
      parent: _turnController,
      curve: Curves.bounceOut,
    );

    // // con forward lanzamos la animación
    // _pruebaController.forward();

    // _pruebaController.addListener(() {
    //   // print(_pruebaController.value);
    //   // print(_pruebaAnimation.value);
    //   // print(_pruebaController.isCompleted);
    //   print(_pruebaController.isDismissed);
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _turnController.dispose();
    super.dispose();
    // _pruebaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: Center(
      //   child: AnimatedBuilder(
      //     animation: _pruebaAnimation,
      //     builder: (BuildContext context, _) {
      //       return IconButton(
      //         onPressed: () {
      //           // lanzamos la animación al inverso
      //           _pruebaController.reverse();
      //         },
      //         icon: Icon(
      //           Icons.forward,
      //           size: 40.0,
      //           color: _pruebaAnimation.value,
      //         ),
      //       );
      //     },
      //   ),
      // ),
      body: Center(
        child: RotationTransition(
          turns: _turnAnimation,
          child: FlutterLogo(
            size: 100.0,
            style: FlutterLogoStyle.horizontal,
          ),
        ),
      ),
    );
  }
}
