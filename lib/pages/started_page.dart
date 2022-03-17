import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
    Timer.periodic(Duration(seconds: 2), (timer) {
      print(timer);
    });
  }

  _onPageChange(int index) {
    _currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                onPageChanged: _onPageChange,
                itemBuilder: (context, index) {
                  return Center(
                    child: Text("A $index"),
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
