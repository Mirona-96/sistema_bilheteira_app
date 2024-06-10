import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqlHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'bilheteira.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE clientes (
        id TEXT PRIMARY KEY,
        nome TEXT NOT NULL,
        contato TEXT NOT NULL,
        email TEXT NOT NULL
      )
      ''');

    await db.execute('''
      CREATE TABLE bilhetes (
        id TEXT PRIMARY KEY,
        evento TEXT NOT NULL,
        descricao TEXT NOT NULL,
        endereco TEXT NOT NULL,
        preco REAL NOT NULL,
        dataValidade TEXT DEFAULT CURRENT_TIMESTAMP
      )
      ''');

    await db.execute('''
      CREATE TABLE vendas (
        id TEXT PRIMARY KEY,
        idCliente TEXT NOT NULL,
        idBilhete TEXT NOT NULL,
        quantidade INTEGER NOT NULL,
        precoTotal REAL NOT NULL,
        dataVenda TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (idCliente) REFERENCES clientes(id)
        FOREIGN KEY (idBilhete) REFERENCES bilhetes(id)
      )
      ''');
  }
}
