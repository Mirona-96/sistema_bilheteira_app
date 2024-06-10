import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistema_bilheteira_app_teste_2/Components/butoes.dart';
import 'package:sistema_bilheteira_app_teste_2/Components/inputfield.dart';
import 'package:sistema_bilheteira_app_teste_2/Controller/bilhete_controller.dart';
import 'package:sistema_bilheteira_app_teste_2/Controller/cliente_controller.dart';
import 'package:sistema_bilheteira_app_teste_2/Controller/venda_controller.dart';
import 'package:sistema_bilheteira_app_teste_2/Models/bilhete.dart';
import 'package:sistema_bilheteira_app_teste_2/Models/cliente.dart';
import 'package:sistema_bilheteira_app_teste_2/Screens/app_drawer.dart';
import 'package:uuid/uuid.dart';

import '../Models/venda.dart';

class VendasPage extends StatefulWidget {
  const VendasPage({Key? key}) : super(key: key);

  @override
  _VendasPageState createState() => _VendasPageState();
}

class _VendasPageState extends State<VendasPage> {
  final VendaController _vendaController = VendaController();
  final BilheteController _bilheteController = BilheteController();
  final ClienteController _clienteController = ClienteController();
  List<Venda> _vendas = [];

  @override
  void initState() {
    super.initState();
    _fetchVendas();
  }

  Future<void> _fetchVendas() async {
    List<Venda> vendas = await _vendaController.fetchVendas();
    setState(() {
      _vendas = vendas;
    });
  }

  void _vendaDialog() async {
    final _formKey = GlobalKey<FormState>();
    final idController = TextEditingController(text: const Uuid().v4());
    final clienteIdController = TextEditingController();
    final bilheteIdController = TextEditingController();
    final quantidadeController = TextEditingController();
    final precoTotalController = TextEditingController();
    final dataVendaController = TextEditingController(
        text: DateFormat('dd-MM-yyyy').format(DateTime.now()));

    showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder(
          future: Future.wait([
            _clienteController.buscarTodos(),
            _bilheteController.fetchBilhetes()
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            List<Cliente> clientes = snapshot.data![0];
            List<Bilhete> bilhetes = snapshot.data![1];

            return AlertDialog(
              title: Text('Realizar Venda'),
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<String>(
                        items: clientes
                            .map((cliente) => DropdownMenuItem<String>(
                                  value: cliente.id,
                                  child: Text(cliente.nome),
                                ))
                            .toList(),
                        onChanged: (value) {
                          clienteIdController.text = value.toString();
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor selecione um cliente';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Cliente'),
                      ),
                      DropdownButtonFormField<String>(
                        items: bilhetes
                            .map((bilhete) => DropdownMenuItem<String>(
                                  value: bilhete.id,
                                  child: Text(bilhete.evento),
                                ))
                            .toList(),
                        onChanged: (value) {
                          bilheteIdController.text = value.toString();
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor selecione um bilhete';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Bilhete'),
                      ),
                      InputField(
                        hint: 'Quantidade',
                        icon: Icons.production_quantity_limits,
                        controller: quantidadeController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor insira a quantidade';
                          }
                          return null;
                        },
                      ),
                      InputField(
                        hint: 'Preço Total',
                        icon: Icons.price_change,
                        controller: precoTotalController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor insira o preço total';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.date_range),
                          hintText: 'Data da Venda',
                          labelText: 'Data da Venda',
                        ),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor insira a data da venda';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Button(
                  label: 'SUBMETER',
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      Venda novaVenda = Venda(
                        id: idController.text,
                        clienteId: clienteIdController.text,
                        bilheteId: bilheteIdController.text,
                        quantidade: int.parse(quantidadeController.text),
                        precoTotal: double.parse(precoTotalController.text),
                        dataVenda: DateFormat('dd-MM-yyyy')
                            .parse(dataVendaController.text),
                      );
                      await _vendaController.adicionar(novaVenda);
                      _fetchVendas();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vendas"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: _vendas.length,
        itemBuilder: (context, index) {
          final venda = _vendas[index];
          return ListTile(
            title: FutureBuilder(
              future: Future.wait([
                _clienteController.getClienteById(venda.clienteId),
                _bilheteController.getBilheteById(venda.bilheteId)
              ] as Iterable<Future>),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                Cliente cliente = snapshot.data![0];
                Bilhete bilhete = snapshot.data![1];
                return Text(
                    'Cliente: ${cliente.nome}, Bilhete: ${bilhete.evento}, Quantidade: ${venda.quantidade}, Preço Total: ${venda.precoTotal.toString()}, Data Venda: ${DateFormat('dd-MM-yyyy').format(venda.dataVenda)}');
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _vendaDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
