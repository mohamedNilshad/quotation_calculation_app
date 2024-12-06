import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotation_calculation/src/core/constants/app_colors.dart';
import 'package:quotation_calculation/src/core/constants/app_strings.dart';
import 'package:quotation_calculation/src/core/constants/sizes.dart';
import 'package:quotation_calculation/src/core/utils/helpers/helper_functions.dart';
import 'package:quotation_calculation/src/core/views/widgets/custom.circular_progress_indicator.dart';
import 'package:quotation_calculation/src/features/home/models/item.model.dart';
import 'package:quotation_calculation/src/features/home/view_models/Items.view_model.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  final _formKey = GlobalKey<FormState>();
  final _itemController = TextEditingController();
  final _reasonController = TextEditingController();
  final _priceController = TextEditingController();
  final _qtyController = TextEditingController();
  final _discountController = TextEditingController();

  List<Item> items = [];
  Item? _selectedItem;
  bool loading = false;

  _loadItems() async {
    setState(() => loading = true);
    items = await context.read<ItemViewModel>().fetchItems();
    setState(() {
      _selectedItem = items.first;
      loading = false;
    });
  }

  @override
  void initState() {
    Future.microtask(() => _loadItems());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !loading,
      replacement: const CCircularProgressIndicator(radius: Sizes.iconLg),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: HelperFunctions.screenWidth(context),
              height: kToolbarHeight,
              margin: const EdgeInsets.symmetric(vertical: Sizes.sm),
              padding: const EdgeInsets.symmetric(horizontal: Sizes.md),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.sm),
                color: AppColors.primary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Net Amount',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.white
                    ),
                  ),
                  Text(
                    '1,900',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.md),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ///form
                    DropdownButton<Item>(
                      hint: const Text("Select an Item"),
                      value: _selectedItem,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      underline: const SizedBox(),
                      onChanged: (Item? newValue) {
                        setState(() => _selectedItem = newValue!);
                      },
                      items: items.map<DropdownMenuItem<Item>>((Item value) {
                        return DropdownMenuItem<Item>(
                          value: value,
                          child: Text(value.itemName),
                        );
                      }).toList(),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text(AppStrings.searchLabel),
                      ),
                      controller: _itemController,
                    ),
                    const SizedBox(height: Sizes.spaceBtwInputField),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text(AppStrings.reasonLabel),
                      ),
                      controller: _reasonController,
                    ),
                    const SizedBox(height: Sizes.spaceBtwInputField),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text(AppStrings.priceLabel),
                      ),
                      controller: _priceController,
                    ),
                    const SizedBox(height: Sizes.spaceBtwInputField),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text(AppStrings.qtyLabel),
                            ),
                            controller: _qtyController,
                          ),
                        ),
                        const SizedBox(width: Sizes.md),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text('${AppStrings.discountLabel} %'),
                            ),
                            controller: _discountController,
                          ),
                        ),
                        const SizedBox(width: Sizes.md),
                        ElevatedButton(
                          child: const Text(AppStrings.addLabel),
                          onPressed: (){
                            FocusScope.of(context).unfocus();
                            print(_itemController.text);
                          },
                        )

                      ],
                    ),
                    const SizedBox(height: Sizes.spaceBtwItems),
                    ///table
                    _buildTable()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTable(){
    return DataTable(
      headingRowColor: WidgetStateProperty.all(AppColors.grey),
      horizontalMargin: 0,
      columnSpacing: 0,

      columns: <DataColumn>[
        _buildTableColumn(title: AppStrings.itemLabel),
        _buildTableColumn(title: AppStrings.priceLabel),
        _buildTableColumn(title: AppStrings.qtyLabel),
        _buildTableColumn(title: AppStrings.discountLabel),
        _buildTableColumn(title: AppStrings.totalLabel),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            _buildDataCell(value: 'itemAitemA'),
            _buildDataCell(value: '100.0'),
            _buildDataCell(value: '5'),
            _buildDataCell(value: '5'),
            _buildDataCell(value: '450'),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            _buildDataCell(value: 'itemA'),
            _buildDataCell(value: '100.0'),
            _buildDataCell(value: '5'),
            _buildDataCell(value: '5'),
            _buildDataCell(value: '450'),
          ],
        ),
      ],
    );
  }

  DataColumn _buildTableColumn({required String title}){
    return DataColumn(
      label: Container(
        alignment: Alignment.center,
        width: (HelperFunctions.screenWidth(context)-(Sizes.md)) / 5.7,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  DataCell _buildDataCell({required String value}){
    return DataCell(
      Container(
        width: (HelperFunctions.screenWidth(context)-(Sizes.md)) / 5.7,
        alignment: Alignment.center,
        child: Text(
          value,
          maxLines: 2,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}
