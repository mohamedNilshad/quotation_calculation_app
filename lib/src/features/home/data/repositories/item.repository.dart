import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:quotation_calculation/src/app/injection_container.dart';
import 'package:quotation_calculation/src/core/error/exception.dart';
import 'package:quotation_calculation/src/core/error/failures.dart';
import 'package:quotation_calculation/src/core/repositories/database_helper.repository.dart';
import 'package:quotation_calculation/src/features/home/models/item.model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ItemRepository {
  final DatabaseHelperRepository databaseHelper = sl<DatabaseHelperRepository>();

  // Delete the database for testing
  Future<void> deleteDatabaseFile() async {
    try {
      final databasesPath = await getDatabasesPath();
      final dbPath = join(databasesPath, 'quotations.db');
      await deleteDatabase(dbPath);
      debugPrint('Database deleted');
    } catch (e) {
      debugPrint('Error deleting database: $e');
    }
  }

  // Fetch all items
  Future<Either<Failure, List<Item>>> getItems() async {
    try{
      final db = await databaseHelper.database;
      final result = await db.query('Item_Details');
      return Right(result.map((e) => Item.fromMap(e)).toList());
    }on RequestException catch (e) {
      return Left(AppFailure(e.message));
    } on TimeoutConnectionException catch (e) {
      return Left(TimeoutFailure(e.message));
    } on FailureException catch (e) {
      return Left(AppFailure(e.message));
    } catch (e) {
      return const Left(AppFailure("Process failed, please try again!"));
    }
  }

  // Add a new item
  Future<Either<Failure, bool>> addItem(Item item) async {
    try{
      final db = await databaseHelper.database;
      await db.insert('Item_Details', item.toMap());
      return const Right(true);
    }on RequestException catch (e) {
      return Left(AppFailure(e.message));
    } on TimeoutConnectionException catch (e) {
      return Left(TimeoutFailure(e.message));
    } on FailureException catch (e) {
      return Left(AppFailure(e.message));
    } catch (e) {
      return const Left(AppFailure("Process failed, please try again!"));
    }
  }
}
