import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/models/user_model.dart';
import 'package:flutter_codigo4_fulltechnology/pages/admin/user_form_page.dart';
import 'package:flutter_codigo4_fulltechnology/services/firebase_service.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/header_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/item_list_widget.dart';

class UserListAdminPage extends StatelessWidget {
  FirebaseService _userservice = FirebaseService(collection: 'users');
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_BRAND_PRIMARY,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: COLOR_BRAND_PRIMARY,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserFormPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(title: "Personal"),
            const SizedBox(
              height: 12.0,
            ),
            StreamBuilder(
              stream: _userReference.snapshots(),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  QuerySnapshot collection = snap.data;
                  List<UserModel> users = collection.docs.map<UserModel>((e) {
                    UserModel user =
                        UserModel.fromJson(e.data() as Map<String, dynamic>);
                    user.id = e.id;
                    return user;
                  }).toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return ItemListWidget(
                        title: users[index].name,
                        status: users[index].status,
                        onDelete: () {},
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserFormPage(
                                userModel: users[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
