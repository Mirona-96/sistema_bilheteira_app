import 'dart:async';
import 'package:sistema_bilheteira_app_teste_2/Database/sqlHelper.dart';
import 'package:sistema_bilheteira_app_teste_2/Models/bilhete.dart';
import 'package:sqflite/sqflite.dart';

class BilheteSQLHelper extends SqlHelper {
  static final BilheteSQLHelper _instance = BilheteSQLHelper._internal();
  factory BilheteSQLHelper() => _instance;

  BilheteSQLHelper._internal();

  Future<int> inserirBilhete(Bilhete bilhete) async {
    Database db = await database;
    return await db.insert('bilhetes', bilhete.toMap());
  }

  Future<List<Bilhete>> buscarTodosBilhetes() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('bilhetes');
    return List.generate(maps.length, (i) {
      return Bilhete.fromMap(maps[i]);
    });
  }

  Future<int> actualizarBilhete(Bilhete bilhete) async {
    Database db = await database;
    return await db.update(
      'bilhetes',
      bilhete.toMap(),
      where: 'id = ?',
      whereArgs: [bilhete.id],
    );
  }

  Future<int> removerBilhete(String id) async {
    Database db = await database;
    return await db.delete(
      'bilhetes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Bilhete?> buscarBilhetePorId(String bilheteId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'bilhetes',
      where: 'id = ?',
      whereArgs: [bilheteId],
    );
    if (maps.isNotEmpty) {
      return Bilhete.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
