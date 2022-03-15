import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';

class ItemListShoppingWidget extends StatelessWidget {
  String title;
  int quantity;
  double price;
  Function onDelete;

  ItemListShoppingWidget({
    required this.title,
    required this.quantity,
    required this.price,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 7.0,
        horizontal: 12.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black87.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(3, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: COLOR_BRAND_PRIMARY,
          child: Text(
            title[0].toUpperCase(),
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 20.0),
          ),
        ),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cant. $quantity  |  Precio: S/. ${price.toStringAsFixed(2)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: COLOR_BRAND_PRIMARY.withOpacity(0.6),
              ),
            ),
            InkWell(
              onTap: () {
                onDelete();
              },
              child: const Text(
                "Eliminar",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        // subtitle: RichText(
        //   text: TextSpan(
        //     children: [
        //       TextSpan(
        //         text: "Cant. 2",
        //         style: TextStyle(
        //           color: Colors.black,
        //         ),
        //       ),
        //       TextSpan(
        //         text: "  |  ",
        //         style: TextStyle(
        //           color: Colors.black,
        //         ),
        //       ),
        //       TextSpan(
        //         text: "Precio: S/. 23.00",
        //         style: TextStyle(
        //           color: Colors.black,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        trailing: Text(
          "S/, ${(price * quantity).toStringAsFixed(2)}",
        ),
      ),
    );
  }
}
