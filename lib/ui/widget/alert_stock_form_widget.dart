import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_codigo4_fulltechnology/models/product_model.dart';
import 'package:flutter_codigo4_fulltechnology/models/stock_model.dart';
import 'package:flutter_codigo4_fulltechnology/services/firebase_service.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/button_primary_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/general_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AlertStockFormWidget extends StatefulWidget {
  // List<Stock> stockList;
  // int stockTotal;
  ProductModel productModel;

  // AlertStockFormWidget({
  //   required this.stockList,
  //   required this.stockTotal,
  // });
  AlertStockFormWidget({
    required this.productModel,
  });

  @override
  State<AlertStockFormWidget> createState() => _AlertStockFormWidgetState();
}

class _AlertStockFormWidgetState extends State<AlertStockFormWidget> {
  String campusName = "Selecciona una sede";
  int indexAux = 0;
  TextEditingController _stockController = TextEditingController(text: "0");
  final FirebaseService _productService =
      FirebaseService(collection: 'products');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 18.0),
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        color: Color(0xfff8f8f8),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          const Text(
            "Stock por sede",
            style: TextStyle(
              color: COLOR_BRAND_PRIMARY,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            children: [
              Text(
                "Stock Total: ${widget.productModel.stockTotal}",
                style: const TextStyle(
                  color: COLOR_BRAND_PRIMARY,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black87.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                campusName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                width: 50.0,
                child: TextFormField(
                  controller: _stockController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "0",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black87.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: widget.productModel.stock.length,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, __) => Divider(
                color: COLOR_BRAND_PRIMARY.withOpacity(0.3),
                indent: 12,
                endIndent: 12,
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    campusName = widget.productModel.stock[index].campus;
                    _stockController.text =
                        widget.productModel.stock[index].stock.toString();
                    indexAux = index;
                    setState(() {});
                  },
                  minLeadingWidth: 0,
                  leading: SvgPicture.asset(
                    "assets/icons/hash.svg",
                    height: 18.0,
                    color: COLOR_BRAND_PRIMARY.withOpacity(0.7),
                  ),
                  title: Text(
                    widget.productModel.stock[index].campus,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing:
                      Text(widget.productModel.stock[index].stock.toString()),
                );
              },
            ),
          ),
          const SizedBox(height: 20.0),
          ButtonPrimaryWidget(
            onPressed: () {
              int value = int.parse(_stockController.text);
              widget.productModel.stock[indexAux].stock = value;
              widget.productModel.stockTotal =
                  widget.productModel.stockTotal - value;
              // widget.productModel.stock.forEach((element) {
              //   print(element.campus);
              //   print(element.stock);
              // });
              _productService.updateProduct(widget.productModel).then((value) {
                if (value.isNotEmpty) {
                  Navigator.pop(context);
                  messageSuccessSnackBar(context, 1);
                }
              });
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
