import 'package:get_it/get_it.dart';
import 'package:quotation_calculation/src/features/home/data/repositories/item.repository.dart';
import 'package:quotation_calculation/src/features/home/view_models/Items.view_model.dart';

final sl = GetIt.instance;
Future<void> init() async {

  sl.registerLazySingleton(()=> ItemViewModel());
  sl.registerLazySingleton<ItemRepository>(()=>ItemRepository());
}
