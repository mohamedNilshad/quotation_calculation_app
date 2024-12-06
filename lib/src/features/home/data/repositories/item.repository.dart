import 'package:quotation_calculation/src/features/home/models/item.model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ItemRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quotations.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

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
  }

  Future<List<Item>> getItems() async {
    final db = await database;
    final result = await db.query('Item_Details');
    return result.map((e) => Item.fromMap(e)).toList();
  }

  Future<int> addItem(Item item) async {
    final db = await database;
    return await db.insert('Item_Details', item.toMap());
  }

}
