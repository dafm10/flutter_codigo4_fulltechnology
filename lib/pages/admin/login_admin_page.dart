import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/pages/admin/home_admin_page.dart';
import 'package:flutter_codigo4_fulltechnology/pages/seller/home_seller_page.dart';
import 'package:flutter_codigo4_fulltechnology/services/firebase_service.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/general_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/textfield_normal_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/textfield_password_widget.dart';
import 'package:flutter_codigo4_fulltechnology/utils/sp_global.dart';

class LoginAdminPage extends StatefulWidget {
  const LoginAdminPage({Key? key}) : super(key: key);

  @override
  State<LoginAdminPage> createState() => _LoginAdminPageState();
}

class _LoginAdminPageState extends State<LoginAdminPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseService _userService = FirebaseService(collection: 'users');
  bool isLoading = false;
  SPGlobal prefs = SPGlobal();

  login() async {
    if (_formKey.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        UserCredential _userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (_userCredential.user != null) {
          String email = _userCredential.user!.email!;
          _userService.getUser(email).then(
            (value) {
              if (value != null) {
                prefs.isLogin = value.role;
                prefs.userName = value.name.split(' ').first;
                prefs.campusId = value.campus;
                prefs.sellerId = value.id!;

                if (value.role == "Administrador") {
                  isLoading = false;
                  setState(() {});
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeAdminPage(),
                    ),
                    (route) => false,
                  );
                } else {
                  isLoading = false;
                  setState(() {});
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeSellerPage(),
                    ),
                    (route) => false,
                  );
                }
              }
            },
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          messageErrorSnackBar(context, 3);
          isLoading = false;
          setState(() {});
        } else if (e.code == "wrong-password") {
          messageErrorSnackBar(context, 4);
          isLoading = false;
          setState(() {});
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_BRAND_PRIMARY,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/back.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        color: Colors.white,
                        height: 100.0,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      const Text(
                        "Full Tecnología",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Bienvenido",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 26.0,
                    horizontal: 16.0,
                  ),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Text(
                            "Iniciar Sesión",
                            style: TextStyle(
                              color: COLOR_BRAND_PRIMARY,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          TextFieldNormalWidget(
                            controller: _emailController,
                            hintText: "Correo Electrónico",
                            icon: "at-sign",
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          TextFieldPasswordWidget(
                            controller: _passwordController,
                            validator: true,
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Container(
                            height: 54.0,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                login();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xff7f77e0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              child: const Text(
                                "Iniciar Sesión",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          isLoading
              ? Container(
                  //color: COLOR_BRAND_PRIMARY.withOpacity(0.4),
                  color: const Color(0xff3A344C).withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
