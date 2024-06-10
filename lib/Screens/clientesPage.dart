import 'package:flutter/material.dart';
import 'package:sistema_bilheteira_app_teste_2/Components/butoes.dart';
import 'package:sistema_bilheteira_app_teste_2/Components/inputfield.dart';
import 'package:sistema_bilheteira_app_teste_2/Controller/cliente_controller.dart';
import 'package:sistema_bilheteira_app_teste_2/Models/cliente.dart';
import 'package:sistema_bilheteira_app_teste_2/Screens/app_drawer.dart';
import 'package:uuid/uuid.dart';

class ClientesPage extends StatefulWidget {
  const ClientesPage({super.key});

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  final ClienteController _controller = ClienteController();
  List<Cliente> _clientes = [];

  @override
  void initState() {
    super.initState();
    _fetchClientes();
  }

  Future<void> _fetchClientes() async {
    List<Cliente> clientes = await _controller.buscarTodos();
    setState(() {
      _clientes = clientes;
    });
  }

  void clienteDialog({Cliente? cliente}) {
    final _formKey = GlobalKey<FormState>();
    final idController =
        TextEditingController(text: cliente?.id ?? const Uuid().v4());
    final nomeController = TextEditingController(text: cliente?.nome ?? '');
    final contatoController =
        TextEditingController(text: cliente?.contato ?? '');
    final emailController = TextEditingController(text: cliente?.email ?? '');

    // Print controller values
    print('ID: ${idController.text}');
    print('Nome: ${nomeController.text}');
    print('Contato: ${contatoController.text}');
    print('Email: ${emailController.text}');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(cliente == null ? 'Adicionar Cliente' : 'Editar Cliente'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(children: [
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
                  hint: "Nome",
                  icon: Icons.account_circle_rounded,
                  controller: nomeController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira o nome do cliente';
                    }
                    return null;
                  },
                ),
                InputField(
                  hint: "Contacto",
                  icon: Icons.phone,
                  controller: contatoController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira o contacto do cliente';
                    }
                    return null;
                  },
                ),
                InputField(
                  hint: "Email",
                  icon: Icons.mail,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira o email do cliente';
                    }
                    return null;
                  },
                ),
              ]),
            ),
          ),
          actions: [
            Button(
              label: 'SUBMETER',
              press: () async {
                if (_formKey.currentState!.validate()) {
                  Cliente novoCliente = Cliente(
                    id: idController.text,
                    nome: nomeController.text,
                    contato: contatoController.text,
                    email: emailController.text,
                  );
                  if (cliente == null) {
                    await _controller.adicionar(novoCliente);
                  } else {
                    await _controller.actualizar(novoCliente);
                  }
                  _fetchClientes();
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
        title: const Text("Clientes"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: _clientes.length,
        itemBuilder: (context, index) {
          final cliente = _clientes[index];
          return ListTile(
            title: Text(_clientes[index].nome),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_clientes[index].contato),
                Text(_clientes[index].email),
              ],
            ),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {
                  clienteDialog(cliente: cliente);
                },
              ),
              IconButton(
                  onPressed: () async {
                    await _controller.remover(cliente.id);
                    _fetchClientes();
                  },
                  icon: Icon(Icons.delete))
            ]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: clienteDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
