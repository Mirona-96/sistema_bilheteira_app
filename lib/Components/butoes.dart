import 'package:flutter/material.dart';
import 'package:sistema_bilheteira_app_teste_2/Components/cores.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback press;
  const Button({super.key, required this.label, required this.press});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: primaryColor),
        child: TextButton(
          onPressed: press,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ));
  }
}
