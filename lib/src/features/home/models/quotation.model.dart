
class Quotation{
  final int? id;
  final int? quotationNo;
  final int itemId;
  final int qty;
  final double discount;
  final double total;

  Quotation({
    this.id,
    this.quotationNo,
    required this.itemId,
    required this.qty,
    required this.discount,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quotationNo': quotationNo,
      'itemId': itemId,
      'qty': qty,
      'discount': discount,
      'total': total,
    };
  }

  factory Quotation.fromMap(Map<String, dynamic> map) {
    return Quotation(
      id: map['id'],
      quotationNo: map['quotationNo'],
      itemId: map['itemId'],
      qty: map['qty'],
      discount: map['discount'],
      total: map['total'],
    );
  }
}