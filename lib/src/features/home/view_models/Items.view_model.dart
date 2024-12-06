
import 'package:flutter/material.dart';
import 'package:quotation_calculation/src/app/injection_container.dart';
import 'package:quotation_calculation/src/features/home/data/repositories/item.repository.dart';
import 'package:quotation_calculation/src/features/home/models/item.model.dart';

class ItemViewModel with ChangeNotifier{
  final ItemRepository _itemRepository = sl<ItemRepository>();
  List<Item> _items = [];

  List<Item> get items => _items;

  Future<List<Item>> fetchItems() async {
    _items = await _itemRepository.getItems();
    notifyListeners();
    return _items;
  }
}