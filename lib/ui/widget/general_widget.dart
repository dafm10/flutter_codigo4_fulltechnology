import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';
import 'package:flutter_codigo4_fulltechnology/utils/const.dart';

void messageSuccessSnackBar(BuildContext context, int type) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: COLOR_SUCCESS_PRIMARY,
      content: Row(
        children: [
          const Icon(Icons.check_circle),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            textMessage[type],
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

void messageErrorSnackBar(BuildContext context, int type) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: COLOR_SUCCESS_PRIMARY,
      content: Row(
        children: [
          const Icon(Icons.warning_amber_outlined),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            textMessage[type],
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
