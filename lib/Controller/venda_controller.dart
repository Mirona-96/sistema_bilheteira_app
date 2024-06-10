import 'package:sistema_bilheteira_app_teste_2/Database/vendaSqlHelper.dart';
import 'package:sistema_bilheteira_app_teste_2/Models/cliente.dart';
import 'package:sistema_bilheteira_app_teste_2/Models/venda.dart';

class VendaController {
  final VendaSQLHelper _databaseHelper = VendaSQLHelper();

  Future<void> adicionar(Venda venda) async {
    await _databaseHelper.inserirVenda(venda);
  }

  Future<List<Venda>> fetchVendas() async {
    return await _databaseHelper.buscarVendas();
  }

  Future<void> actualizar(Venda venda) async {
    await _databaseHelper.actualizarVenda(venda);
  }

  Future<void> remover(String id) async {
    await _databaseHelper.removerVenda(id);
  }

  adicionarVenda(Venda newVenda) {}
}
