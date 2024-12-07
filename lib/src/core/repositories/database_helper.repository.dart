import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:quotation_calculation/src/features/home/models/item.model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperRepository {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quotations.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    debugPrint('DB created');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    const String tblName = 'Item_Details';

    await db.execute('''
      CREATE TABLE $tblName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        itemName TEXT NOT NULL,
        price DOUBLE NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE Quotation_Details (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        quotationNo INTEGER NOT NULL,
        qty INTEGER NOT NULL,
        discount DOUBLE NOT NULL,
        total DOUBLE NOT NULL,
        itemId INTEGER NOT NULL,
        CONSTRAINT fk_Item_Details FOREIGN KEY (itemId) REFERENCES $tblName (id)
      )
    ''');
    debugPrint('Tables created');
    await _initTable(db, tblName);
  }

  Future<void> _initTable(Database db, String tblName)async {
    List<Item> items = [
      Item(itemName: 'Item 1', price: 50.00),
      Item(itemName: 'Item 2', price: 60.00),
      Item(itemName: 'Item 3', price: 70.00),
    ];
    for(Item item in items){
      await db.insert(tblName, item.toMap());
    }
    debugPrint('Tables initiated');
  }
}
