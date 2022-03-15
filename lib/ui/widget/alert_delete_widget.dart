import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';

class AlertDeleteWidget extends StatelessWidget {
  final Function onDelete;

  const AlertDeleteWidget({
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 17.0,
          vertical: 16.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Eliminar Registro",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: COLOR_BRAND_PRIMARY.withOpacity(0.7),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              width: double.infinity,
              height: 3.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: COLOR_ERROR_PRIMART.withOpacity(0.7),
              ),
            ),
            Text(
              "El registro se eliminará de forma permanente, ¿deseas continuar de todas formas?",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14.0,
                color: COLOR_BRAND_PRIMARY.withOpacity(0.7),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  color: const Color(0xfff8f8f8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  width: 10.0,
                ),
                MaterialButton(
                  color: COLOR_ERROR_PRIMART.withOpacity(0.9),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  textColor: Colors.white,
                  child: const Text("Eliminar"),
                  onPressed: () {
                    onDelete();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
