import 'package:dartz/dartz.dart';
import 'package:quotation_calculation/src/app/injection_container.dart';
import 'package:quotation_calculation/src/core/error/exception.dart';
import 'package:quotation_calculation/src/core/error/failures.dart';
import 'package:quotation_calculation/src/core/repositories/database_helper.repository.dart';
import 'package:quotation_calculation/src/features/home/models/quotation.model.dart';

class QuotationRepository {
  final DatabaseHelperRepository databaseHelper = sl<DatabaseHelperRepository>();

  //fetch QuotationNo
  Future<Either<Failure, int>> getQuotationNo() async {
    try{
      final db = await databaseHelper.database;
      var results = await db.query(
        'Quotation_Details',
        columns: ['quotationNo'],
        orderBy: 'id DESC',
        limit: 1,
      );
      return Right(results.isNotEmpty ? (results.first['quotationNo'] as int) + 1 : 1);
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

  //add new Quotation
  Future<Either<Failure, bool>> addQuotation({required List<Quotation> quotations}) async {
    try{
      final db = await databaseHelper.database;
      for(var quotation in quotations) {
        await db.insert('Quotation_Details', quotation.toMap());
      }
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

  //fetch all Quotations
  Future<Either<Failure, List<Quotation>>> getQuotations() async {
    try{
      final db = await databaseHelper.database;
      final result = await db.query('Quotation_Details');
      return Right(result.map((e) => Quotation.fromMap(e)).toList());
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
