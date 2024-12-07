
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:quotation_calculation/src/app/injection_container.dart';
import 'package:quotation_calculation/src/core/constants/app_strings.dart';
import 'package:quotation_calculation/src/core/error/failures.dart';
import 'package:quotation_calculation/src/core/views/widgets/custom.snackbar.dart';
import 'package:quotation_calculation/src/features/home/data/repositories/item.repository.dart';
import 'package:quotation_calculation/src/features/home/models/item.model.dart';

class ItemViewModel with ChangeNotifier{
  final ItemRepository _itemRepository = sl<ItemRepository>();
  List<Item> _items = [];

  List<Item> get items => _items;

  Future<List<Item>> fetchItems(BuildContext context) async {
    try {
      Either<Failure, List<Item>> result = await _itemRepository.getItems();
      return result.fold((l) {
        customSnackBar(context, l.message);
        return _items;
      }, (List<Item> item) {
        _items = item;
        notifyListeners();
        return _items;
      });
    } catch (error) {
      customSnackBar(context, AppStrings.appUnrecognisedError);
    }
    return _items;
  }

  Future<void> deleteDb() async {
    await _itemRepository.deleteDatabaseFile();
    notifyListeners();
  }
}