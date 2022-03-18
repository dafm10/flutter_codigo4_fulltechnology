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
      body: Padding(
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
                      "https://images.pexels.com/photos/11334018/pexels-photo-11334018.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text("María de todos los Angeles"),
                ],
              ),
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
            ],
          ),
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