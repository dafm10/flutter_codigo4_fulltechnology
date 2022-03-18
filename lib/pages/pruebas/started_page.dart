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
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: slideList.length,
                onPageChanged: _onPageChange,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          "assets/images/${slideList[index].image}.png"),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        slideList[index].title,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        slideList[index].subtitle,
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

class Slide {
  final String image;
  final String title;
  final String subtitle;

  Slide({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

final slideList = [
  Slide(
    image: '1',
    title: "Empecemos con nuestra App",
    subtitle:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod elit ex, ut aliquam leo efficitur vel.",
  ),
  Slide(
    image: '2',
    title: "Empecemos con nuestra App",
    subtitle:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod elit ex, ut aliquam leo efficitur vel.",
  ),
  Slide(
    image: '3',
    title: "Empecemos con nuestra App",
    subtitle:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod elit ex, ut aliquam leo efficitur vel.",
  ),
];
