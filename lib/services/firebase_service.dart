import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_codigo4_fulltechnology/models/category_model.dart';
import 'package:flutter_codigo4_fulltechnology/models/product_model.dart';
import 'package:flutter_codigo4_fulltechnology/models/product_sale_model.dart';
import 'package:flutter_codigo4_fulltechnology/models/sale_model.dart';
import 'package:flutter_codigo4_fulltechnology/models/user_model.dart';

class FirebaseService {
  final String collection;
  FirebaseService({
    required this.collection,
  });
  late final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(collection);

  Future<List<GeneralModel>> getGeneralList() async {
    List<GeneralModel> list = [];
    QuerySnapshot collection =
        await _collectionReference.orderBy('description').get();
    if (collection.docs.isNotEmpty) {
      collection.docs.forEach((QueryDocumentSnapshot element) {
        Map<String, dynamic> myMap = element.data() as Map<String, dynamic>;
        GeneralModel generalModel = GeneralModel.fromJson(myMap);
        generalModel.id = element.id;
        list.add(generalModel);
      });
      return list;
    }
    return [];
  }

  Future<List<ProductModel>> getProductList() async {
    List<ProductModel> products = [];
    QuerySnapshot collection =
        await _collectionReference.orderBy('description').get();
    if (collection.docs.isNotEmpty) {
      collection.docs.forEach((QueryDocumentSnapshot element) {
        Map<String, dynamic> myMap = element.data() as Map<String, dynamic>;
        ProductModel productModel = ProductModel.fromJson(myMap);
        productModel.id = element.id;
        products.add(productModel);
      });
      return products;
    }
    return [];
  }

  Future<List<UserModel>> getUserList() async {
    // List<UserModel> userList = [];
    // QuerySnapshot collection = await _collectionReference.get();
    // if (collection.docs.isNotEmpty) {
    //   collection.docs.forEach((element) {
    //     Map<String, dynamic> myMap = element.data() as Map<String, dynamic>;
    //     UserModel _user = UserModel.fromJson(myMap);
    //     _user.id = element.id;
    //     userList.add(_user);
    //   });
    // }

    try {
      List<UserModel> userList = [];
      QuerySnapshot collection = await _collectionReference.get();
      if (collection.docs.isNotEmpty) {
        collection.docs.forEach((element) {
          Map<String, dynamic> myMap = element.data() as Map<String, dynamic>;
          UserModel _user = UserModel.fromJson(myMap);
          _user.id = element.id;
          userList.add(_user);
        });
      }
      return userList;
    } on TimeoutException catch (e) {
      return Future.error("Error 1 $e");
    } on SocketException catch (e) {
      return Future.error("Error 2 $e");
    } on Error catch (e) {
      return Future.error("Error 3 $e");
    }
  }

  deleteItem(String id) async {
    try {
      await _collectionReference.doc(id).delete();
      return 1;
    } on TimeoutException catch (e) {
      return Future.error("Error 1 $e");
    } on SocketException catch (e) {
      return Future.error("Error 2 $e");
    } on Error catch (e) {
      return Future.error("Error 3 $e");
    }
  }

  Future<String> updateGeneral(GeneralModel model) async {
    try {
      await _collectionReference.doc(model.id).update(model.toJson());
      return model.id!;
    } on TimeoutException catch (e) {
      return Future.error("Error 1 $e");
    } on SocketException catch (e) {
      return Future.error("Error 2 $e");
    } on Error catch (e) {
      return Future.error("Error 3 $e");
    }
  }

  Future<String> addGeneral(GeneralModel model) async {
    try {
      DocumentReference _document =
          await _collectionReference.add(model.toJson());
      return _document.id;
    } on TimeoutException catch (e) {
      return Future.error("Error 1 $e");
    } on SocketException catch (e) {
      return Future.error("Error 2 $e");
    } on Error catch (e) {
      return Future.error("Error 3 $e");
    }
  }

  Future<String> addProduct(ProductModel model) async {
    try {
      DocumentReference _document =
          await _collectionReference.add(model.toJson());
      return _document.id;
    } on TimeoutException catch (e) {
      return Future.error("Error 1 $e");
    } on SocketException catch (e) {
      return Future.error("Error 2 $e");
    } on Error catch (e) {
      return Future.error("Error 3 $e");
    }
  }

  Future<String> updateProduct(ProductModel model) async {
    try {
      await _collectionReference.doc(model.id).update(model.toJson());
      return model.id!;
    } on TimeoutException catch (e) {
      return Future.error("Error 1 $e");
    } on SocketException catch (e) {
      return Future.error("Error 2 $e");
    } on Error catch (e) {
      return Future.error("Error 3 $e");
    }
  }

  Future<String> addUser(UserModel userModel) async {
    try {
      DocumentReference document =
          await _collectionReference.add(userModel.toJson());
      return document.id;
    } on TimeoutException catch (e) {
      return Future.error("Error 1 $e");
    } on SocketException catch (e) {
      return Future.error("Error 2 $e");
    } on Error catch (e) {
      return Future.error("Error 3 $e");
    }
  }

  Future<String> updateUser(UserModel userModel) async {
    try {
      await _collectionReference.doc(userModel.id).update(userModel.toJson());
      return userModel.id!;
    } on TimeoutException catch (e) {
      return Future.error("Error 1 $e");
    } on SocketException catch (e) {
      return Future.error("Error 2 $e");
    } on Error catch (e) {
      return Future.error("Error 3 $e");
    }
  }

  Future<UserModel?> getUser(String email) async {
    try {
      QuerySnapshot collection =
          await _collectionReference.where('email', isEqualTo: email).get();
      if (collection.docs.isNotEmpty) {
        QueryDocumentSnapshot doc = collection.docs.first;
        Map<String, dynamic> myMap = doc.data() as Map<String, dynamic>;
        UserModel userModel = UserModel.fromJson(myMap);
        userModel.id = doc.id;
        return userModel;
      }
    } on TimeoutException catch (e) {
      return Future.error("Error 1 $e");
    } on SocketException catch (e) {
      return Future.error("Error 2 $e");
    } on Error catch (e) {
      return Future.error("Error 3 $e");
    }
  }

  Future<String> addSale(SaleModel model) async {
    try {
      DocumentReference document =
          await _collectionReference.add(model.toJson());
      return document.id;
    } on TimeoutException catch (e) {
      return Future.error("Error 1 $e");
    } on SocketException catch (e) {
      return Future.error("Error 2 $e");
    } on Error catch (e) {
      return Future.error("Error 3 $e");
    }
  }
}
