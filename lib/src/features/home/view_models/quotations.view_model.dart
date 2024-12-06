
import 'package:flutter/material.dart';
import 'package:quotation_calculation/src/app/injection_container.dart';
import 'package:quotation_calculation/src/features/home/data/repositories/item.repository.dart';
import 'package:quotation_calculation/src/features/home/models/quotation.model.dart';

class QuotationViewModel with ChangeNotifier{
  final ItemRepository _itemRepository = sl<ItemRepository>();
  List<Quotation> _quotations = [];

  List<Quotation> get quotations => _quotations;

  Future<List<Quotation>> fetchQuotations() async {
    _quotations = await _itemRepository.getItems();
    notifyListeners();
    return _quotations;
  }
}