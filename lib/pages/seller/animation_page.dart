// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/pages/seller/animated_controller_page.dart';
import 'package:flutter_codigo4_fulltechnology/pages/seller/hero_page.dart';
import 'package:flutter_codigo4_fulltechnology/pages/seller/navigator_2_page.dart';
import 'package:flutter_codigo4_fulltechnology/pages/seller/tween_page.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  bool flagAnimationAlign = true;
  bool flagAnimationContainer = true;
  bool flagAnimationCross = true;
  bool flagAnimationPh = true;
  double flagOpacity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                const Text(
                  "Hero Animation",
                ),
                Hero(
                  tag: 'batman',
                  child: Image.asset("assets/images/batman.jpg"),
                ),
                CupertinoButton(
                  child: const Text("Hero!"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HeroPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Animated Align",
                ),
                GestureDetector(
                  onTap: () {
                    flagAnimationAlign = !flagAnimationAlign;
                    setState(() {});
                  },
                  child: Container(
                    height: 300.0,
                    width: 300.0,
                    color: Colors.deepPurpleAccent,
                    child: AnimatedAlign(
                      curve: Curves.bounceOut,
                      alignment: flagAnimationAlign
                          ? Alignment.topRight
                          : Alignment.bottomRight,
                      duration: const Duration(milliseconds: 2200),
                      child: Image.asset(
                        "assets/images/batman.jpg",
                        width: 100.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Animated Container",
                ),
                GestureDetector(
                  onTap: () {
                    flagAnimationContainer = !flagAnimationContainer;
                    setState(() {});
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.bounceOut,
                    height: flagAnimationContainer ? 200.0 : 100,
                    width: flagAnimationContainer ? 200.0 : 100,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    child: const FlutterLogo(
                      size: 60.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Animated CrossFade",
                ),
                AnimatedCrossFade(
                  firstChild: GestureDetector(
                    onTap: () {
                      flagAnimationCross = !flagAnimationCross;
                      setState(() {});
                    },
                    child: const FlutterLogo(
                      size: 200.0,
                      style: FlutterLogoStyle.horizontal,
                    ),
                  ),
                  secondChild: GestureDetector(
                    onTap: () {
                      flagAnimationCross = !flagAnimationCross;
                      setState(() {});
                    },
                    child: const FlutterLogo(
                      size: 200.0,
                      style: FlutterLogoStyle.stacked,
                    ),
                  ),
                  crossFadeState: flagAnimationCross
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 1400),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Animated AnimatedDefaultTextStyle",
                ),
                Container(
                  width: 200.0,
                  height: 200.00,
                  color: Colors.indigo,
                  child: const AnimatedDefaultTextStyle(
                    child: Text("Hola Child"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    duration: Duration(milliseconds: 1200),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Animated AnimatedOpacity",
                ),
                AnimatedOpacity(
                  opacity: flagOpacity,
                  duration: const Duration(milliseconds: 500),
                  child: const FlutterLogo(
                    style: FlutterLogoStyle.markOnly,
                    size: 200.0,
                  ),
                  curve: Curves.easeIn,
                ),
                CupertinoButton(
                  child: const Text("Click!"),
                  onPressed: () {
                    flagOpacity = flagOpacity == 1 ? 0 : 1;
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Animated AnimatedPhysicalModel",
                ),
                AnimatedPhysicalModel(
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    child: const FlutterLogo(
                      size: 100.0,
                    ),
                  ),
                  shape: BoxShape.rectangle,
                  elevation: flagAnimationPh ? 30 : 0,
                  color: Colors.white,
                  borderRadius: flagAnimationPh
                      ? const BorderRadius.all(Radius.circular(40.0))
                      : const BorderRadius.all(Radius.circular(0)),
                  shadowColor: Colors.black45,
                  duration: const Duration(milliseconds: 1200),
                ),
                CupertinoButton(
                  child: const Text("Click!"),
                  onPressed: () {
                    flagAnimationPh = !flagAnimationPh;
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Animated AnimatedPositioned",
                ),
                Container(
                  height: 200.0,
                  width: 350.0,
                  color: Colors.indigo,
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        height: 40.0,
                        width: 40.0,
                        right: 120.0,
                        top: 100.0,
                        curve: Curves.bounceInOut,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        duration: const Duration(milliseconds: 1200),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AnimatedControllerPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Animated Controller",
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TweenPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Tween Animation",
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      newRoute(),
                    );
                  },
                  child: const Text(
                    "Navigator Animated",
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Route newRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) {
        return const Navigator2Page();
      },
      transitionsBuilder: (context, animation1, animation2, child) {
        Offset begin = const Offset(0, 1);
        Offset end = Offset.zero;
        Curve curve = Curves.bounceOut;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        Animation<Offset> newAnimation = animation1.drive(tween);

        return SlideTransition(
          position: newAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 1200),
    );
  }
}
