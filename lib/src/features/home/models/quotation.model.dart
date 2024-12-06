
import 'package:quotation_calculation/src/features/home/models/item.model.dart';

class Quotation{
  final int? id;
  final Item item;
  final int qty;
  final double discount;
  final double total;

  Quotation({
    this.id,
    required this.item,
    required this.qty,
    required this.discount,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item': item,
      'qty': qty,
      'discount': discount,
      'total': total,
    };
  }

  factory Quotation.fromMap(Map<String, dynamic> map) {
    return Quotation(
      id: map['id'],
      item: map['item'],
      qty: map['qty'],
      discount: map['discount'],
      total: map['total'],
    );
  }
}