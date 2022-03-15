import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';
import 'package:flutter_svg/svg.dart';

class ButtonPrimaryWidget extends StatelessWidget {
  final Function onPressed;

  ButtonPrimaryWidget({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52.0,
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        color: COLOR_BRAND_PRIMARY,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/save.svg',
              color: Colors.white,
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Text(
              "Guardar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
