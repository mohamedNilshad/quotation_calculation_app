
import 'package:flutter/material.dart';
import 'package:quotation_calculation/src/features/home/models/item.model.dart';
import 'package:search_choices/search_choices.dart';
class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final List<Item> items = [
    Item(id: 1, itemName: "Item A", price: 10.0),
    Item(id: 2, itemName: "Item B", price: 20.0),
    Item(id: 3, itemName: "Item C", price: 30.0),
  ];

  Item? selectedItem;
  double? selectedPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('examples mode')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchChoices.single(
              items: items.map((item) => DropdownMenuItem<Item>(
                value: item,
                child: Text(item.itemName),
              )).toList(),
              value: selectedItem,
              hint: "Select an Item",
              onChanged: (Item? selected) {
                setState(() {
                  selectedItem = selected;
                  selectedPrice = selected?.price;
                });
              },
              isExpanded: true,
              displayClearIcon: true,
              icon: const Icon(Icons.arrow_downward),
              searchHint: "Search Item...",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            if(selectedItem != null && selectedPrice != null)
              Text(
                'Selected Item: ${selectedItem?.itemName}, Price: \$${selectedPrice?.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),

      ),
    );
  }
}
