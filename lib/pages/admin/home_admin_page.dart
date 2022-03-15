import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/pages/admin/general_list_admin_page.dart';
import 'package:flutter_codigo4_fulltechnology/pages/admin/login_admin_page.dart';
import 'package:flutter_codigo4_fulltechnology/pages/admin/user_list__admin_page.dart';
import 'package:flutter_codigo4_fulltechnology/pages/admin/warehouse_list_admin_page.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/item_menu_widget.dart';
import 'package:flutter_codigo4_fulltechnology/utils/sp_global.dart';

class HomeAdminPage extends StatelessWidget {
  SPGlobal prefs = SPGlobal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: const Text(
      //     "Full Tecnología",
      //     style: TextStyle(
      //       color: Colors.black87,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
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
                            "hola ${prefs.userName}",
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
                  title: "Almacén",
                  image:
                      "https://images.pexels.com/photos/3937174/pexels-photo-3937174.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WarehouseListAdminPage(
                                  collection: "products",
                                  title: "Productos",
                                  title2: "Producto",
                                )));
                  },
                ),
                ItemMenuWidget(
                  title: "Marcas",
                  image:
                      "https://images.pexels.com/photos/2708981/pexels-photo-2708981.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GeneralListAdminPage(
                          collection: "brands",
                          title: "Marcas",
                          title2: "Marca",
                        ),
                      ),
                    );
                  },
                ),
                ItemMenuWidget(
                  title: "Categorías",
                  image:
                      "https://images.pexels.com/photos/1779487/pexels-photo-1779487.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GeneralListAdminPage(
                          collection: "categories",
                          title: "Categorías",
                          title2: "Categoría",
                        ),
                      ),
                    );
                  },
                ),
                ItemMenuWidget(
                  title: "Sedes",
                  image:
                      "https://images.pexels.com/photos/3970330/pexels-photo-3970330.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GeneralListAdminPage(
                          collection: "campus",
                          title: "Sedes",
                          title2: "Sede",
                        ),
                      ),
                    );
                  },
                ),
                ItemMenuWidget(
                  title: "Personal",
                  image:
                      "https://images.pexels.com/photos/2007647/pexels-photo-2007647.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserListAdminPage(),
                      ),
                    );
                  },
                ),
                ItemMenuWidget(
                  title: "Reportes",
                  image:
                      "https://images.pexels.com/photos/1448709/pexels-photo-1448709.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
