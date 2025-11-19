import 'package:inovola/core/models/purchased_item.dart';
import 'package:inovola/core/models/purchased_item_category.dart';
import 'package:inovola/core/models/time_period.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PurchasedItemDatabase {
  static final PurchasedItemDatabase instance = PurchasedItemDatabase._init();
  static Database? _database;

  PurchasedItemDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('purchased_items.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const realType = 'REAL NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE purchased_items (
        id $idType,
        price $realType,
        purchaseDate $textType,
        category $textType,
        medium $textType
      )
    ''');
  }

  Future<void> insertItem(PurchasedItem item) async {
    final db = await instance.database;
    await db.insert(
      'purchased_items',
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertItems(List<PurchasedItem> items) async {
    final db = await instance.database;
    final batch = db.batch();

    for (var item in items) {
      batch.insert(
        'purchased_items',
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<PurchasedItem>> getAllItems() async {
    final db = await instance.database;
    final result = await db.query('purchased_items');
    return result.map((json) => PurchasedItem.fromJson(json)).toList();
  }

  Future<List<PurchasedItem>> getItemsPaginated({
    required int page,
    required int pageSize,
    TimePeriod? period,
  }) async {
    final db = await instance.database;
    final offset = page * pageSize;

    String? whereClause;
    List<dynamic>? whereArgs;

    if (period != null) {
      final now = DateTime.now();
      DateTime startDate;

      switch (period) {
        case TimePeriod.LAST_HOUR:
          startDate = now.subtract(const Duration(hours: 1));
          break;
        case TimePeriod.TODAY:
          startDate = DateTime(now.year, now.month, now.day);
          break;
        case TimePeriod.THIS_WEEK:
          startDate = now.subtract(Duration(days: now.weekday - 1));
          startDate = DateTime(startDate.year, startDate.month, startDate.day);
          break;
        case TimePeriod.THIS_MONTH:
          startDate = DateTime(now.year, now.month, 1);
          break;
      }

      whereClause = 'purchaseDate >= ?';
      whereArgs = [startDate.toIso8601String()];
    }

    final result = await db.query(
      'purchased_items',
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: 'purchaseDate DESC',
      limit: pageSize,
      offset: offset,
    );

    return result.map((json) => PurchasedItem.fromJson(json)).toList();
  }

  Future<int> getItemsCount({TimePeriod? period}) async {
    final db = await instance.database;

    String? whereClause;
    List<dynamic>? whereArgs;

    if (period != null) {
      final now = DateTime.now();
      DateTime startDate;

      switch (period) {
        case TimePeriod.LAST_HOUR:
          startDate = now.subtract(const Duration(hours: 1));
          break;
        case TimePeriod.TODAY:
          startDate = DateTime(now.year, now.month, now.day);
          break;
        case TimePeriod.THIS_WEEK:
          startDate = now.subtract(Duration(days: now.weekday - 1));
          startDate = DateTime(startDate.year, startDate.month, startDate.day);
          break;
        case TimePeriod.THIS_MONTH:
          startDate = DateTime(now.year, now.month, 1);
          break;
      }

      whereClause = 'purchaseDate >= ?';
      whereArgs = [startDate.toIso8601String()];
    }

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM purchased_items ${whereClause != null ? 'WHERE $whereClause' : ''}',
      whereArgs,
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<List<PurchasedItem>> getItemsByTimePeriod(TimePeriod period) async {
    final db = await instance.database;
    final now = DateTime.now();
    DateTime startDate;

    switch (period) {
      case TimePeriod.LAST_HOUR:
        startDate = now.subtract(const Duration(hours: 1));
        break;
      case TimePeriod.TODAY:
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case TimePeriod.THIS_WEEK:
        startDate = now.subtract(Duration(days: now.weekday - 1));
        startDate = DateTime(startDate.year, startDate.month, startDate.day);
        break;
      case TimePeriod.THIS_MONTH:
        startDate = DateTime(now.year, now.month, 1);
        break;
    }

    final result = await db.query(
      'purchased_items',
      where: 'purchaseDate >= ?',
      whereArgs: [startDate.toIso8601String()],
      orderBy: 'purchaseDate DESC',
    );

    return result.map((json) => PurchasedItem.fromJson(json)).toList();
  }

  Future<List<PurchasedItem>> getItemsByCategory(PurchasedItemCategory category) async {
    final db = await instance.database;
    final result = await db.query(
      'purchased_items',
      where: 'category = ?',
      whereArgs: [category.name],
      orderBy: 'purchaseDate DESC',
    );
    return result.map((json) => PurchasedItem.fromJson(json)).toList();
  }

  Future<List<PurchasedItem>> getItemsByCategoryAndPeriod(
    PurchasedItemCategory category,
    TimePeriod period,
  ) async {
    final db = await instance.database;
    final now = DateTime.now();
    DateTime startDate;

    switch (period) {
      case TimePeriod.LAST_HOUR:
        startDate = now.subtract(const Duration(hours: 1));
        break;
      case TimePeriod.TODAY:
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case TimePeriod.THIS_WEEK:
        startDate = now.subtract(Duration(days: now.weekday - 1));
        startDate = DateTime(startDate.year, startDate.month, startDate.day);
        break;
      case TimePeriod.THIS_MONTH:
        startDate = DateTime(now.year, now.month, 1);
        break;
    }

    final result = await db.query(
      'purchased_items',
      where: 'category = ? AND purchaseDate >= ?',
      whereArgs: [category.name, startDate.toIso8601String()],
      orderBy: 'purchaseDate DESC',
    );

    return result.map((json) => PurchasedItem.fromJson(json)).toList();
  }

  Future<int> deleteAllItems() async {
    final db = await instance.database;
    return await db.delete('purchased_items');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
