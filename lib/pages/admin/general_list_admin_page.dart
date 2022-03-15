import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/models/category_model.dart';
import 'package:flutter_codigo4_fulltechnology/services/firebase_service.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/alert_delete_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/alert_form_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/general_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/header_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/item_list_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/message_empty_widget.dart';

class GeneralListAdminPage extends StatelessWidget {
  final String collection;
  final String title;
  final String title2;

  GeneralListAdminPage({
    required this.collection,
    required this.title,
    required this.title2,
  });

  GeneralModel? categoryModel;
  late final CollectionReference _categoriesReference =
      FirebaseFirestore.instance.collection(collection);

  //final String collection = "categories";
  late final FirebaseService _myFirebaseService =
      FirebaseService(collection: collection);

  showDeleteAlert(BuildContext context) {
    showDialog(
      barrierColor: COLOR_BRAND_PRIMARY.withOpacity(0.6),
      context: context,
      builder: (context) {
        return AlertDeleteWidget(
          onDelete: () {
            _myFirebaseService.deleteItem(categoryModel!.id!).then((value) {
              if (value == 1) {
                Navigator.pop(context);
                // mostras un mensaje de éxito
                messageSuccessSnackBar(context, 0);
              }
            }).catchError((error) {
              print(error);
            });
          },
        );
      },
    );
  }

  showAddForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: COLOR_BRAND_PRIMARY.withOpacity(0.5),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: AlertFormWidget(
            title: "Agregar $title2",
            type: true,
            collection: collection,
          ),
        );
      },
    );
  }

  showUpdateForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: COLOR_BRAND_PRIMARY.withOpacity(0.5),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: AlertFormWidget(
            title: "Modificar $title2",
            type: false,
            generalModel: categoryModel,
            collection: collection,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xff28293B),
        appBar: AppBar(
          backgroundColor: COLOR_BRAND_PRIMARY,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: COLOR_BRAND_PRIMARY,
          onPressed: () {
            showAddForm(context);
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderWidget(title: title),
                const SizedBox(
                  height: 12.0,
                ),
                StreamBuilder(
                  stream: _categoriesReference
                      .orderBy('description', descending: false)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.hasData) {
                      QuerySnapshot collection = snap.data;

                      List<GeneralModel> categories =
                          collection.docs.map<GeneralModel>((e) {
                        GeneralModel category = GeneralModel.fromJson(
                            e.data() as Map<String, dynamic>);
                        category.id = e.id;
                        return category;
                      }).toList();

                      return categories.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                return ItemListWidget(
                                  title: categories[index].description,
                                  status: categories[index].status,
                                  onDelete: () {
                                    categoryModel = categories[index];
                                    showDeleteAlert(context);
                                  },
                                  onEdit: () {
                                    categoryModel = categories[index];
                                    showUpdateForm(context);
                                  },
                                );
                              },
                            )
                          : const MessageEmptyWidget();
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
