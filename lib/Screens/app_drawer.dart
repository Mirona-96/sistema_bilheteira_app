import 'package:flutter/material.dart';
import 'package:sistema_bilheteira_app_teste_2/Components/cores.dart';
import 'package:sistema_bilheteira_app_teste_2/Models/menuItems.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: primaryColor, // Set the background color for the entire drawer
        child: Column(
          children: [
            Container(
              height: 200, // Fixed height for the header
              child: const Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),

            //o menu principal
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: menuItems.map((menuItem) {
                  return ListTile(
                    leading: Icon(menuItem.icon, color: Colors.white),
                    title: Text(menuItem.titulo,
                        style: const TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pushNamed(context, menuItem.pagina);
                    },
                  );
                }).toList(),
              ),
            ),

            //o log out
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text('Sair', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Handle logout action
                Navigator.pop(context); // Close the drawer
                // Add your logout logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
