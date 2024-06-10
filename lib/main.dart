import 'package:flutter/material.dart';
import 'package:sistema_bilheteira_app_teste_2/Components/cores.dart';
import 'package:sistema_bilheteira_app_teste_2/Screens/bilhetesPage.dart';
import 'package:sistema_bilheteira_app_teste_2/Screens/clientesPage.dart';
import 'package:sistema_bilheteira_app_teste_2/Screens/home_page.dart';
import 'package:sistema_bilheteira_app_teste_2/Screens/vendasPage.dart';
//import 'package:sistema_bilheteira_app_teste_2/Screens/visualizar_clientes_page.dart';
//import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //sqfliteFfiInit();
  //databaseFactory = databaseFactoryFfi;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de Gestão de Bilheteira',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      ),
      initialRoute: '/homepage',
      routes: {
        '/homepage': (context) => const HomePage(),
        '/clientes': (context) => const ClientesPage(),
        '/bilhetes': (context) => const BilhetesPage(),
        '/vendas': (context) => const VendasPage()
      },
    );
  }
}
