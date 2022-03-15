import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemListSellerWidget extends StatelessWidget {
  String title;
  int stock;
  Function onAddShopping;

  ItemListSellerWidget({
    required this.title,
    required this.stock,
    required this.onAddShopping,
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
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Stock: $stock",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: COLOR_BRAND_PRIMARY.withOpacity(0.6),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                onAddShopping();
              },
              icon: SvgPicture.asset(
                'assets/icons/shopping-cart.svg',
                height: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
