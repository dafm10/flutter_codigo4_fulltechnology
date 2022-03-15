import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextFieldNormalWidget extends StatelessWidget {
  final String hintText;
  final String icon;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final int? maxLines;
  final bool? isNumeric;

  TextFieldNormalWidget({
    required this.hintText,
    required this.icon,
    this.controller,
    this.textInputType,
    this.maxLines,
    this.isNumeric,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              hintText + ":",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: COLOR_BRAND_PRIMARY.withOpacity(0.07),
                  offset: const Offset(4, 4),
                  blurRadius: 12.0),
            ],
          ),
          child: TextFormField(
              maxLines: maxLines,
              controller: controller,
              keyboardType: textInputType,
              inputFormatters: isNumeric != null
                  ? [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ]
                  : [],
              decoration: InputDecoration(
                hintText: hintText,
                filled: true,
                fillColor: Colors.white,
                prefixIcon: SvgPicture.asset(
                  "assets/icons/$icon.svg",
                  height: 20.0,
                  fit: BoxFit.scaleDown,
                  color: COLOR_BRAND_PRIMARY.withOpacity(0.7),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "El campo no puede estar vacío";
                }
                return null;
              }),
        ),
        SizedBox(
          height: 12.0,
        ),
      ],
    );
  }
}
