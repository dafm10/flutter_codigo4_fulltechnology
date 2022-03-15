import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/responsive.dart';

class MessageEmptyWidget extends StatelessWidget {
  const MessageEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsiveUI = ResponsiveUI(context);
    return SizedBox(
      height: responsiveUI.hp(60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/box.png",
            height: 80.0,
          ),
          const SizedBox(
            height: 12.0,
          ),
          const Text(
            "Aún no hay registros.",
          ),
        ],
      ),
    );
  }
}
