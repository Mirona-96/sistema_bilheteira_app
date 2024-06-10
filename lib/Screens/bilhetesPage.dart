import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistema_bilheteira_app_teste_2/Components/butoes.dart';
import 'package:sistema_bilheteira_app_teste_2/Components/inputfield.dart';
import 'package:sistema_bilheteira_app_teste_2/Controller/bilhete_controller.dart';
import 'package:sistema_bilheteira_app_teste_2/Models/bilhete.dart';
import 'package:sistema_bilheteira_app_teste_2/Screens/app_drawer.dart';
import 'package:uuid/uuid.dart';

class BilhetesPage extends StatefulWidget {
  const BilhetesPage({super.key});

  @override
  State<BilhetesPage> createState() => _BilhetesPageState();
}

class _BilhetesPageState extends State<BilhetesPage> {
  final BilheteController _controller = BilheteController();
  List<Bilhete> _bilhetes = [];

  @override
  void initState() {
    super.initState();
    _fetchBilhetes();
  }

  Future<void> _fetchBilhetes() async {
    List<Bilhete> bilhetes = await _controller.fetchBilhetes();
    setState(() {
      _bilhetes = bilhetes;
    });
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd-MM-yyyy')
            .format(picked); // Formata data para dd-MM-yyyy
      });
    }
  }

  void bilheteDialog({Bilhete? bilhete}) {
    final _formKey = GlobalKey<FormState>();
    final idController =
        TextEditingController(text: bilhete?.id ?? const Uuid().v4());
    final eventoController = TextEditingController(text: bilhete?.evento ?? '');
    final descricaoController =
        TextEditingController(text: bilhete?.descricao ?? '');
    final enderecoController =
        TextEditingController(text: bilhete?.endereco ?? '');
    final precoController =
        TextEditingController(text: bilhete?.preco.toString() ?? '');
    final dataValidadeController = TextEditingController(
      text: bilhete != null
          ? DateFormat('dd-MM-yyyy').format(bilhete.dataValidade)
          : '',
    );

    // Print controller values
    print('ID: ${idController.text}');
    print('Evento: ${eventoController.text}');
    print('Descrição: ${descricaoController.text}');
    print('Endereço: ${enderecoController.text}');
    print('Preço: ${precoController.text}');
    print('Data Validade: ${dataValidadeController.text}');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(bilhete == null ? 'Adicionar Bilhete' : 'Editar Bilhete'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    enabled: false,
                    controller: idController,
                    decoration: InputDecoration(
                      labelText: 'ID',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    hint: "Evento",
                    icon: Icons.event,
                    controller: eventoController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira o nome do evento';
                      }
                      return null;
                    },
                  ),
                  InputField(
                    hint: "Descrição",
                    icon: Icons.description,
                    controller: descricaoController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira a descrição do evento';
                      }
                      return null;
                    },
                  ),
                  InputField(
                    hint: "Endereço",
                    icon: Icons.location_on,
                    controller: enderecoController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira o endereço do evento';
                      }
                      return null;
                    },
                  ),
                  InputField(
                    hint: "Preço",
                    icon: Icons.attach_money,
                    controller: precoController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira o preço do bilhete';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: dataValidadeController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.date_range),
                      hintText: 'Data de Validade',
                      labelText: 'Data de Validade',
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await _selectDate(context, dataValidadeController);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira a data de validade do bilhete';
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
                  Bilhete novoBilhete = Bilhete(
                    id: idController.text,
                    evento: eventoController.text,
                    descricao: descricaoController.text,
                    endereco: enderecoController.text,
                    preco: double.parse(precoController.text),
                    dataValidade: DateFormat('dd-MM-yyyy')
                        .parse(dataValidadeController.text),
                  );
                  if (bilhete == null) {
                    await _controller.adicionar(novoBilhete);
                  } else {
                    await _controller.actualizar(novoBilhete);
                  }
                  _fetchBilhetes();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bilhetes"),
      ),
      drawer: AppDrawer(),
      body: GridView.builder(
        itemCount: _bilhetes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.8, // Adjust this to fit your design
        ),
        itemBuilder: (context, index) {
          final bilhete = _bilhetes[index];
          return Card(
            color: index % 2 == 0
                ? Colors.blue.shade100
                : Colors.green.shade100, // Background color
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bilhete.evento,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(bilhete.descricao),
                  SizedBox(height: 5),
                  Text(bilhete.endereco),
                  SizedBox(height: 5),
                  Text('Preço: ${bilhete.preco.toString()} MT'),
                  SizedBox(height: 5),
                  Text(
                      'Validade: ${DateFormat('dd-MM-yyyy').format(bilhete.dataValidade)}'),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          bilheteDialog(bilhete: bilhete);
                        },
                      ),
                      IconButton(
                        onPressed: () async {
                          await _controller.remover(bilhete.id);
                          _fetchBilhetes();
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: bilheteDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
