import 'dart:async';

import 'package:sistema_bilheteira_app_teste_2/Database/sqlHelper.dart';
import 'package:sistema_bilheteira_app_teste_2/Models/cliente.dart';
import 'package:sqflite/sqflite.dart';

class ClienteSQLHelper extends SqlHelper {
  static final ClienteSQLHelper _instance = ClienteSQLHelper._internal();
  factory ClienteSQLHelper() => _instance;

  ClienteSQLHelper._internal();

  Future<int> inserirCLiente(Cliente cliente) async {
    Database db = await database;
    return await db.insert('Clientes', cliente.toMap());
  }

  Future<List<Cliente>> buscarTodosClientes() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('Clientes');
    return List.generate(maps.length, (i) {
      return Cliente.fromMap(maps[i]);
    });
  }

  Future<int> actualizarCliente(Cliente Cliente) async {
    Database db = await database;
    return await db.update(
      'Clientes',
      Cliente.toMap(),
      where: 'id = ?',
      whereArgs: [Cliente.id],
    );
  }

  Future<int> removerCliente(String id) async {
    Database db = await database;
    return await db.delete(
      'Clientes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Cliente?> buscarClientePorId(String ClienteId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'Clientes',
      where: 'id = ?',
      whereArgs: [ClienteId],
    );
    if (maps.isNotEmpty) {
      return Cliente.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
