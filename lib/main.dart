import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/pages/admin/home_admin_page.dart';
import 'package:flutter_codigo4_fulltechnology/pages/admin/login_admin_page.dart';
import 'package:flutter_codigo4_fulltechnology/pages/seller/home_seller_page.dart';
import 'package:flutter_codigo4_fulltechnology/pages/pruebas/started_page.dart';
import 'package:flutter_codigo4_fulltechnology/provider/shopping_provider.dart';
import 'package:flutter_codigo4_fulltechnology/utils/push_notification_service.dart';
import 'package:flutter_codigo4_fulltechnology/utils/sp_global.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SPGlobal prefs = SPGlobal();
  await prefs.initShared();
  await Firebase.initializeApp();
  await PushNotificationService.initilizedApp();
  // Firebase.initializeApp().then((value) {
  //   runApp(const MyApp());
  // });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => ShoppingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Full Tecnología",
        theme: ThemeData(
          textTheme: GoogleFonts.manropeTextTheme(),
        ),
        home: StartedPage(),
      ),
    );
  }
}

class PreInit extends StatelessWidget {
  Future<String> getRole() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("isLogin") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRole(),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.hasData) {
          String role = snap.data;
          if (role == "Administrador") {
            return HomeAdminPage();
          } else if (role == "Vendedor") {
            return HomeSellerPage();
          } else {
            return LoginAdminPage();
          }
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
