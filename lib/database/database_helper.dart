import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contato.dart';

/// DatabaseHelper - singleton responsável pelo CRUD usando sqflite
class DatabaseHelper {
  static const _databaseName = 'contatos.db';
  static const _databaseVersion = 1;
  static const tableContatos = 'contatos';

  // Singleton
  DatabaseHelper._init();
  static final DatabaseHelper instance = DatabaseHelper._init();

  Database? _database;

  /// Getter para o database (inicializa se necessário)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, _databaseName);
      return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
      );
    } catch (e) {
      // Propaga o erro para o chamador após log
      // ignore: avoid_print
      print('Erro inicializando banco: $e');
      rethrow;
    }
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableContatos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        numeroConta TEXT NOT NULL,
        dataCriacao TEXT
      )
    ''');
  }

  /// Insere um novo contato. Retorna o id inserido.
  Future<int> create(Contato contato) async {
    try {
      final db = await database;
      final id = await db.insert(tableContatos, contato.toMap());
      return id;
    } catch (e) {
      // ignore: avoid_print
      print('Erro ao criar contato: $e');
      rethrow;
    }
  }

  /// Lê todos os contatos do banco, ordenados por nome
  Future<List<Contato>> readAll() async {
    try {
      final db = await database;
      final result =
          await db.query(tableContatos, orderBy: 'nome COLLATE NOCASE ASC');
      return result.map((map) => Contato.fromMap(map)).toList();
    } catch (e) {
      // ignore: avoid_print
      print('Erro ao ler todos contatos: $e');
      rethrow;
    }
  }

  /// Lê contato por id
  Future<Contato?> readById(int id) async {
    try {
      final db = await database;
      final maps = await db.query(
        tableContatos,
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) return Contato.fromMap(maps.first);
      return null;
    } catch (e) {
      // ignore: avoid_print
      print('Erro ao ler contato por id: $e');
      rethrow;
    }
  }

  /// Atualiza um contato. Retorna número de linhas afetadas.
  Future<int> update(Contato contato) async {
    try {
      final db = await database;
      return await db.update(
        tableContatos,
        contato.toMap(),
        where: 'id = ?',
        whereArgs: [contato.id],
      );
    } catch (e) {
      // ignore: avoid_print
      print('Erro ao atualizar contato: $e');
      rethrow;
    }
  }

  /// Deleta um contato pelo id. Retorna número de linhas deletadas.
  Future<int> delete(int id) async {
    try {
      final db = await database;
      return await db.delete(
        tableContatos,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      // ignore: avoid_print
      print('Erro ao deletar contato: $e');
      rethrow;
    }
  }

  /// Fecha a instância do banco
  Future close() async {
    try {
      final db = await database;
      await db.close();
      _database = null;
    } catch (e) {
      // ignore: avoid_print
      print('Erro ao fechar o banco: $e');
      rethrow;
    }
  }
}
