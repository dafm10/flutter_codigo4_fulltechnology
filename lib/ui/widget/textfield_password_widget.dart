import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextFieldPasswordWidget extends StatefulWidget {
  TextEditingController? controller;
  bool validator;
  TextFieldPasswordWidget({
    this.controller,
    required this.validator,
  });

  @override
  State<TextFieldPasswordWidget> createState() =>
      _TextFieldPasswordWidgetState();
}

class _TextFieldPasswordWidgetState extends State<TextFieldPasswordWidget> {
  bool isInvisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              "Contraseña: ",
              style: TextStyle(
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
              maxLines: 1,
              controller: widget.controller,
              obscureText: isInvisible,
              decoration: InputDecoration(
                hintText: "Contraseña",
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                    onPressed: () {
                      isInvisible = !isInvisible;
                      setState(() {});
                    },
                    icon: Icon(
                      isInvisible
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined,
                      color: const Color(0xff7f77e0).withOpacity(0.7),
                    )),
                prefixIcon: SvgPicture.asset(
                  "assets/icons/lock.svg",
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
                if (!widget.validator) {
                  return null;
                }
                if (value!.isEmpty) {
                  return "El campo no puede estar vacío";
                }
                return null;
              }),
        ),
        const SizedBox(
          height: 12.0,
        ),
      ],
    );
  }
}
