import 'package:flutter/material.dart';
import 'package:sistema_bilheteira_app_teste_2/Controller/bilhete_controller.dart';
import 'package:sistema_bilheteira_app_teste_2/Controller/cliente_controller.dart';
import 'package:sistema_bilheteira_app_teste_2/Screens/app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ClienteController _clienteController = ClienteController();
  final BilheteController _bilheteController = BilheteController();
  int _numClientes = 0;
  int _numBilhetes = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    int? numClientes = await _clienteController.contarClientes();
    int? numBilhetes = await _bilheteController.contarBilhetes();
    setState(() {
      _numClientes = numClientes ?? 0; // Se numClientes for null, atribui 0
      _numBilhetes = numBilhetes ?? 0; // Se numBilhetes for null, atribui 0
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de Gestão de Bilheteira'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Número de Clientes Registrados: $_numClientes',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Número de Bilhetes Registrados: $_numBilhetes',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
