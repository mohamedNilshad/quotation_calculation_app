
class Item{
  final int? id;
  final String itemName;
  final double price;

  Item({
    this.id,
    required this.itemName,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'itemName': itemName, 'price': price};
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(id: map['id'], itemName: map['itemName'], price: map['price']);
  }
}