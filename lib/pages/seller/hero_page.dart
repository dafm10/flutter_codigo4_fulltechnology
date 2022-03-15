import 'package:flutter/material.dart';

class HeroPage extends StatelessWidget {
  const HeroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'batman',
              child: Image.asset(
                "assets/images/batman.jpg",
                height: 120.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
