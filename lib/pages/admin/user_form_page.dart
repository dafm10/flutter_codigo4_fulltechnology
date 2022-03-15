import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/models/category_model.dart';
import 'package:flutter_codigo4_fulltechnology/models/user_model.dart';
import 'package:flutter_codigo4_fulltechnology/services/firebase_service.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/button_primary_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/general_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/textfield_normal_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/textfield_password_widget.dart';
import 'package:flutter_codigo4_fulltechnology/utils/const.dart';

class UserFormPage extends StatefulWidget {
  UserModel? userModel;

  UserFormPage({
    this.userModel,
  });

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseService _campusService = FirebaseService(collection: 'campus');
  final FirebaseService _userService = FirebaseService(collection: 'users');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String roleValue = "";
  List<GeneralModel> campusList = [];
  String idCampus = "";
  bool status = true;
  bool isLoading = true;
  bool validatorPassword = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    roleValue = roleList[0];
    _campusService.getGeneralList().then((value) {
      campusList = value;
      idCampus = campusList.first.id!;
      if (widget.userModel != null) {
        _nameController.text = widget.userModel!.name;
        _phoneController.text = widget.userModel!.phone;
        _emailController.text = widget.userModel!.email;
        _addressController.text = widget.userModel!.address;
        roleValue = widget.userModel!.role;
        idCampus = widget.userModel!.campus;
        status = widget.userModel!.status;
        validatorPassword = false;
      }
      isLoading = false;
      setState(() {});
    });
  }

  void register() async {
    if (_formKey.currentState!.validate()) {
      UserModel userModel = UserModel(
        address: _addressController.text,
        role: roleValue,
        phone: _phoneController.text,
        campus: idCampus,
        name: _nameController.text,
        email: _emailController.text,
        status: status,
      );
      if (widget.userModel == null) {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );
          if (userCredential.user != null) {
            _userService.addUser(userModel).then((value) {
              if (value.isNotEmpty) {
                messageSuccessSnackBar(context, 2);
                Navigator.pop(context);
              }
            });
          }
        } on FirebaseAuthException catch (e) {
          print(e);
        }
      } else {
        // UserCredential userCredential =
        //     await FirebaseAuth.instance.signInWithEmailAndPassword(
        //   email: _emailController.text,
        //   password: "3volution",
        // );
        // print(userCredential.user);
        // User? user = FirebaseAuth.instance.currentUser;
        //print(user);
        userModel.id = widget.userModel!.id;
        _userService.updateUser(userModel).then((value) {
          messageSuccessSnackBar(context, 1);
          Navigator.pop(context);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_BRAND_PRIMARY,
        elevation: 0,
        title: const Text("Agregar Personal"),
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
                        hintText: "Nombre completo",
                        icon: 'user',
                        controller: _nameController,
                      ),
                      TextFieldNormalWidget(
                        hintText: "Teléfono",
                        icon: 'phone',
                        textInputType: TextInputType.phone,
                        controller: _phoneController,
                      ),
                      TextFieldNormalWidget(
                        hintText: "Correo electrónico",
                        icon: 'at-sign',
                        controller: _emailController,
                      ),
                      TextFieldNormalWidget(
                        hintText: "Dirección",
                        icon: 'map',
                        controller: _addressController,
                      ),
                      Row(
                        children: const [
                          Text(
                            "Rol:",
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
                            value: roleValue,
                            items: roleList
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ),
                                )
                                .toList(),
                            onChanged: (String? value) {
                              roleValue = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Row(
                        children: const [
                          Text(
                            "Sede:",
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
                            value: idCampus,
                            items: campusList
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text(e.description),
                                    value: e.id,
                                  ),
                                )
                                .toList(),
                            onChanged: (String? value) {
                              idCampus = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      widget.userModel == null
                          ? TextFieldPasswordWidget(
                              controller: _passwordController,
                              validator: validatorPassword,
                            )
                          : Container(),
                      Row(
                        children: [
                          const Text(
                            "Estado: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Checkbox(
                            activeColor: COLOR_BRAND_PRIMARY,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            value: status,
                            onChanged: (bool? value) {
                              status = value!;
                              setState(() {});
                            },
                          ),
                        ],
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
