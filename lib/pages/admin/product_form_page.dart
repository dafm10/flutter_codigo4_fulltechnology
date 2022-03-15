import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/models/category_model.dart';
import 'package:flutter_codigo4_fulltechnology/models/product_model.dart';
import 'package:flutter_codigo4_fulltechnology/models/stock_model.dart';
import 'package:flutter_codigo4_fulltechnology/services/firebase_service.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/button_primary_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/general_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/textfield_normal_widget.dart';
import 'package:flutter_codigo4_fulltechnology/utils/const.dart';

class ProductFormPage extends StatefulWidget {
  ProductModel? productModel;
  ProductFormPage({
    this.productModel,
  });

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  List<GeneralModel> categoryList = [];
  List<GeneralModel> brandList = [];
  List<GeneralModel> campusList = [];
  List<Stock> stockList = [];

  String idCategory = "";
  String idBrand = "";
  String productSize = "";
  bool isLoading = true;
  final FirebaseService _categoryService =
      FirebaseService(collection: 'categories');
  final FirebaseService _brandService = FirebaseService(collection: 'brands');
  final FirebaseService _productService =
      FirebaseService(collection: 'products');
  final FirebaseService _campusService = FirebaseService(collection: 'campus');

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _specificationController =
      TextEditingController();
  final TextEditingController _modelController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _categoryService.getGeneralList().then((value) {
    //   categoryList = value;
    //   idCategory = categoryList.first.id!;
    //   setState(() {});
    // });
    getData();
  }

  getData() async {
    productSize = productSizeList[0];
    _categoryService.getGeneralList().then((value) {
      categoryList = value;
      idCategory = categoryList.first.id!;
      isLoading = false;
      setState(() {});
    });
    _campusService.getGeneralList().then((value) {
      campusList = value;
      campusList.forEach((element) {
        stockList.add(
          Stock(id: element.id, campus: element.description, stock: 0),
        );
      });
    });
    _brandService.getGeneralList().then((value) {
      brandList = value;
      idBrand = brandList.first.id!;
      isLoading = false;
      // si entramos a ProductFormPage para agregar o editar
      if (widget.productModel != null) {
        _descriptionController.text = widget.productModel!.description;
        _modelController.text = widget.productModel!.model;
        _specificationController.text = widget.productModel!.specification;
        _stockController.text = widget.productModel!.stockTotal.toString();
        _priceController.text = widget.productModel!.price.toStringAsFixed(2);
        idBrand = widget.productModel!.brand;
        idCategory = widget.productModel!.category;
        productSize = widget.productModel!.size;
      }
      setState(() {});
    });
  }

  register() {
    if (_formKey.currentState!.validate()) {
      ProductModel productModel = ProductModel(
        size: productSize,
        price: double.parse(_priceController.text),
        stockTotal: int.parse(_stockController.text),
        specification: _specificationController.text,
        description: _descriptionController.text,
        model: _modelController.text,
        category: idCategory,
        stock: stockList,
        brand: idBrand,
      );

      if (widget.productModel == null) {
        _productService.addProduct(productModel).then((value) {
          messageSuccessSnackBar(context, 2);
          Navigator.pop(context);
        });
      } else {
        productModel.id = widget.productModel!.id;
        productModel.stock = widget.productModel!.stock;
        _productService.updateProduct(productModel);
        messageSuccessSnackBar(context, 1);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_BRAND_PRIMARY,
        elevation: 0,
        title: const Text("Agregar producto"),
      ),
      body: !isLoading
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldNormalWidget(
                        hintText: "Descripción",
                        icon: 'align-left',
                        controller: _descriptionController,
                      ),
                      Row(
                        children: const [
                          Text(
                            "Marca:",
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
                        height: 62.0,
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        margin: const EdgeInsets.only(
                          bottom: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: COLOR_BRAND_PRIMARY.withOpacity(0.07),
                              offset: const Offset(4, 4),
                              blurRadius: 12.0,
                            ),
                          ],
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: idBrand,
                            items: brandList
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e.id,
                                    child: Text(e.description),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? value) {
                              idBrand = value!;
                              print(idBrand);
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      TextFieldNormalWidget(
                        hintText: "Modelo",
                        icon: 'tag',
                        controller: _modelController,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFieldNormalWidget(
                              hintText: "Stock",
                              icon: 'hash',
                              textInputType: TextInputType.number,
                              isNumeric: true,
                              controller: _stockController,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: TextFieldNormalWidget(
                              hintText: "Precio",
                              icon: 'money',
                              textInputType: TextInputType.number,
                              isNumeric: true,
                              controller: _priceController,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Text(
                            "Categoría:",
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
                        height: 62.0,
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        margin: const EdgeInsets.only(
                          bottom: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: COLOR_BRAND_PRIMARY.withOpacity(0.07),
                                offset: const Offset(4, 4),
                                blurRadius: 12.0),
                          ],
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: idCategory,
                            items: categoryList
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e.id,
                                    child: Text(e.description),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? value) {
                              idCategory = value!;
                              //print(value);
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      TextFieldNormalWidget(
                        hintText: "Especificaciones",
                        icon: 'clipboard',
                        maxLines: 3,
                        controller: _specificationController,
                      ),
                      Row(
                        children: const [
                          Text(
                            "Tamaño:",
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
                        height: 62.0,
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        margin: const EdgeInsets.only(
                          bottom: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: COLOR_BRAND_PRIMARY.withOpacity(0.07),
                                offset: const Offset(4, 4),
                                blurRadius: 12.0),
                          ],
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: productSize,
                            items: productSizeList
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? value) {
                              productSize = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      ButtonPrimaryWidget(
                        onPressed: () {
                          register();
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
