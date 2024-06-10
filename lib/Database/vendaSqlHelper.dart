import 'dart:async';

import 'package:sistema_bilheteira_app_teste_2/Database/sqlHelper.dart';
import 'package:sistema_bilheteira_app_teste_2/Models/venda.dart';
import 'package:sqflite/sqflite.dart';

class VendaSQLHelper extends SqlHelper {
  static final VendaSQLHelper _instance = VendaSQLHelper._internal();
  factory VendaSQLHelper() => _instance;

  VendaSQLHelper._internal();

  Future<int> inserirVenda(Venda venda) async {
    Database db = await database;
    return await db.insert('vendas', venda.toMap());
  }

  Future<List<Venda>> buscarVendas() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('vendas');
    return List.generate(maps.length, (i) {
      return Venda.fromMap(maps[i]);
    });
  }

  Future<int> actualizarVenda(Venda venda) async {
    Database db = await database;
    return await db.update(
      'vendas',
      venda.toMap(),
      where: 'id = ?',
      whereArgs: [venda.id],
    );
  }

  Future<int> removerVenda(String id) async {
    Database db = await database;
    return await db.delete(
      'vendas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
