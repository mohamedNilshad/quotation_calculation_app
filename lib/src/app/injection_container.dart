import 'package:get_it/get_it.dart';
import 'package:quotation_calculation/src/core/repositories/database_helper.repository.dart';
import 'package:quotation_calculation/src/features/home/data/repositories/item.repository.dart';
import 'package:quotation_calculation/src/features/home/data/repositories/quotation.repository.dart';
import 'package:quotation_calculation/src/features/home/view_models/Items.view_model.dart';
import 'package:quotation_calculation/src/features/home/view_models/quotations.view_model.dart';

final sl = GetIt.instance;
Future<void> init() async {

  sl.registerLazySingleton(()=> DatabaseHelperRepository());

  sl.registerLazySingleton(()=> ItemViewModel());
  sl.registerLazySingleton<ItemRepository>(()=>ItemRepository());

  sl.registerLazySingleton(()=> QuotationViewModel());
  sl.registerLazySingleton<QuotationRepository>(()=>QuotationRepository());
}
