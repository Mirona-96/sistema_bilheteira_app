import 'package:sistema_bilheteira_app_teste_2/Database/clienteSqlHelper.dart';
import 'package:sistema_bilheteira_app_teste_2/Models/cliente.dart';

class ClienteController {
  final ClienteSQLHelper _databaseHelper = ClienteSQLHelper();

  Future<void> adicionar(Cliente cliente) async {
    await _databaseHelper.inserirCLiente(cliente);
  }

  Future<List<Cliente>> buscarTodos() async {
    return await _databaseHelper.buscarTodosClientes();
  }

  Future<void> actualizar(Cliente cliente) async {
    await _databaseHelper.actualizarCliente(cliente);
  }

  Future<void> remover(String id) async {
    await _databaseHelper.removerCliente(id);
  }

  adicionarCliente(Cliente newCliente) {}

  getClienteById(String clienteId) async {
    return await _databaseHelper.buscarClientePorId(clienteId);
  }
}
