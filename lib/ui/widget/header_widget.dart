import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';

class HeaderWidget extends StatelessWidget {
  final String title;

  HeaderWidget({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
      decoration: const BoxDecoration(
        color: COLOR_BRAND_PRIMARY,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(34.0),
          bottomRight: Radius.circular(34.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Full Tecnología",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
