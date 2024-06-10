import 'package:sistema_bilheteira_app_teste_2/Database/bilheteSqlHelper.dart';
import 'package:sistema_bilheteira_app_teste_2/Models/bilhete.dart';

class BilheteController {
  final BilheteSQLHelper _databaseHelper = BilheteSQLHelper();

  Future<void> adicionar(Bilhete bilhete) async {
    await _databaseHelper.inserirBilhete(bilhete);
  }

  Future<List<Bilhete>> fetchBilhetes() async {
    return await _databaseHelper.buscarTodosBilhetes();
  }

  Future<void> actualizar(Bilhete bilhete) async {
    await _databaseHelper.actualizarBilhete(bilhete);
  }

  Future<void> remover(String id) async {
    await _databaseHelper.removerBilhete(id);
  }

  Future<Bilhete?> getBilheteById(String bilheteId) async {
    return await _databaseHelper.buscarBilhetePorId(bilheteId);
  }

  contarBilhetes() {}
}
