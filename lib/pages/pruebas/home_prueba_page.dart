import 'package:flutter/material.dart';

class HomePruebPage extends StatefulWidget {
  const HomePruebPage({Key? key}) : super(key: key);

  @override
  State<HomePruebPage> createState() => _HomePruebPageState();
}

class _HomePruebPageState extends State<HomePruebPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Page1(),
          Page2(),
        ],
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  double xOffset = 100;
  double yOffset = 0;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..rotateZ(isActive ? -50 : 0)
        ..scale(isActive ? 0.88 : 1.0),
      duration: const Duration(milliseconds: 1200),
      color: Colors.green,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                xOffset = 200;
                yOffset = 90;
                isActive = true;
                setState(() {});
              },
              child: const Text("Aceptar"),
            ),
            Container(
              height: 300.0,
              color: Colors.indigo,
            ),
            Container(
              height: 300.0,
              color: Colors.redAccent,
            ),
            Container(
              height: 300.0,
              color: Colors.greenAccent,
            ),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, bottom: 50.0, left: 40.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/8744113/pexels-photo-8744113.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text("María de todos los Angeles"),
              ],
            ),
            const SizedBox(height: 40.0),
            Column(
              children: [
                NewItem(
                  icon: Icons.error_outline,
                  title: "Configuración",
                ),
                const SizedBox(height: 20.0),
                NewItem(
                  icon: Icons.person_outline,
                  title: "Perfil",
                ),
                const SizedBox(height: 20.0),
                NewItem(
                  icon: Icons.chat_bubble_outline,
                  title: "Mensajes",
                ),
                const SizedBox(height: 20.0),
                NewItem(
                  icon: Icons.history_outlined,
                  title: "Historial",
                ),
                const SizedBox(height: 20.0),
                NewItem(
                  icon: Icons.bookmark_outline,
                  title: "Guardados",
                ),
                const SizedBox(height: 20.0),
                NewItem(
                  icon: Icons.home_outlined,
                  title: "General",
                ),
                const SizedBox(height: 20.0),
              ],
            ),
            Expanded(child: Container()),
            Row(
              children: const [
                Icon(Icons.cancel_outlined),
                SizedBox(width: 10.0),
                Text("Cerrar Sesión"),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              children: const [
                Icon(Icons.add_chart_outlined),
                SizedBox(width: 10.0),
                Text("Acerca de nosotros"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NewItem extends StatelessWidget {
  IconData icon;
  String title;

  NewItem({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 20.0,
        ),
        Text(title),
      ],
    );
  }
}
