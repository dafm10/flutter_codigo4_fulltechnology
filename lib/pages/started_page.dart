import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartedPage extends StatefulWidget {
  const StartedPage({Key? key}) : super(key: key);

  @override
  State<StartedPage> createState() => _StartedPageState();
}

class _StartedPageState extends State<StartedPage> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentIndex < 2) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    });
  }

  _onPageChange(int index) {
    _currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                onPageChanged: _onPageChange,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200.0,
                        width: 200.0,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Tus primeros pasos para nuestra App",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod elit ex, ut aliquam leo efficitur vel.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                CupertinoButton(
                  color: Colors.black87,
                  child: const Text("Getting Started"),
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Have an account?. Register",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
