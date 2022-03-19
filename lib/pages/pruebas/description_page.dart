import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/pages/pruebas/responsive.platform.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({Key? key}) : super(key: key);

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    // if (Platform.isAndroid) {
    //   print("Estamos en Android");
    // } else if (Platform.isIOS) {
    //   print("Estamos en iOS");
    // }

    // if (kIsWeb) {
    //   print("Estamos en web");
    // }

    // print(MediaQuery.of(context).orientation);

    // return ResponsivePlatform(
    //   mobile: Scaffold(
    //     body: Center(
    //       child: Text("Estoy en un smartphone"),
    //     ),
    //   ),
    //   tablet: Scaffold(
    //     body: Center(
    //       child: Text("Estoy en una tablet"),
    //     ),
    //   ),
    //   desktop: Scaffold(
    //     body: Center(
    //       child: Text("Estoy en una desktop"),
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text("Hola"),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          print(orientation);
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            children: [
              Center(child: Text("1")),
              Center(child: Text("2")),
              Center(child: Text("3")),
              Center(child: Text("4")),
              Center(child: Text("5")),
              Center(child: Text("6")),
            ],
          );
        },
      ),
    );
  }
}
