import 'package:flutter/material.dart';
import 'package:sistema_bilheteira_app_teste_2/Components/cores.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuState();
}

class _MenuState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 200,
            height: double.infinity,
            decoration: BoxDecoration(color: primaryColor),
          )
        ],
      ),
    );
  }
}
