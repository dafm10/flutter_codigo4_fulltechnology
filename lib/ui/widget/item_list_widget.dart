import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemListWidget extends StatelessWidget {
  final String title;
  final bool? status;
  final int? stock;
  final double? price;
  final Function onDelete;
  final Function onEdit;

  ItemListWidget({
    required this.title,
    this.status,
    this.price,
    this.stock,
    required this.onDelete,
    required this.onEdit,
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
            status != null
                ? Text(status! ? "Estado: Activo" : "Estado: Desactivo")
                : Container(),
            stock != null
                ? Text(
                    "Stock: $stock",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: COLOR_BRAND_PRIMARY.withOpacity(0.6),
                    ),
                  )
                : Container(),
            price != null
                ? Text(
                    "Precio: S/. ${price!.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: COLOR_BRAND_PRIMARY.withOpacity(0.6),
                    ),
                  )
                : Container(),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                onDelete();
              },
              icon: SvgPicture.asset(
                'assets/icons/trash.svg',
                height: 20.0,
              ),
            ),
            IconButton(
              onPressed: () {
                onEdit();
              },
              icon: SvgPicture.asset(
                'assets/icons/edit.svg',
                height: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
