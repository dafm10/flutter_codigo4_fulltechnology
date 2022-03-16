import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/pages/admin/login_admin_page.dart';
import 'package:flutter_codigo4_fulltechnology/pages/seller/animation_page.dart';
import 'package:flutter_codigo4_fulltechnology/pages/seller/dashboard_page.dart';
import 'package:flutter_codigo4_fulltechnology/pages/seller/sale_page.dart';
import 'package:flutter_codigo4_fulltechnology/pages/seller/ventas_seller_page.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/item_menu_widget.dart';
import 'package:flutter_codigo4_fulltechnology/utils/sp_global.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomeSellerPage extends StatelessWidget {
  SPGlobal prefs = SPGlobal();

  showNotification() {
    FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      "full_tecnologia_channerl",
      "Full Tecnología",
      description: "Es un canal con mucha prioridad",
    );

    _flutterLocalNotificationsPlugin.show(
      0,
      "Hola",
      "Compra mas seguido",
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(shoppingProvider.productLength);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.message),
        onPressed: () {
          showNotification();
        },
      ),
      backgroundColor: const Color(0xff2C3145),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 45.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 16.0,
                            backgroundImage:
                                AssetImage("assets/images/user.png"),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Hola ${prefs.userName}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () async {
                          prefs.userName = "";
                          prefs.campusId = "";
                          prefs.isLogin = "";
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginAdminPage()),
                              (route) => false);
                        },
                        icon: const Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "Full Tecnología",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              childAspectRatio: 1.2,
              //mainAxisSpacing: 12.0,
              children: [
                ItemMenuWidget(
                  title: "Venta",
                  image:
                      "https://images.pexels.com/photos/3937174/pexels-photo-3937174.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SalePage(),
                      ),
                    );
                  },
                ),
                ItemMenuWidget(
                  title: "Mis Ventas",
                  image:
                      "https://images.pexels.com/photos/2708981/pexels-photo-2708981.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VentasSellerPage()),
                    );
                  },
                ),
                ItemMenuWidget(
                  title: "Resumen",
                  image:
                      "https://images.pexels.com/photos/1779487/pexels-photo-1779487.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(),
                      ),
                    );
                  },
                ),
                ItemMenuWidget(
                  title: "Animation",
                  image:
                      "https://images.pexels.com/photos/1779487/pexels-photo-1779487.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimationPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
