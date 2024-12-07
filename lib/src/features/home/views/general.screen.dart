
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quotation_calculation/src/core/constants/app_colors.dart';
import 'package:quotation_calculation/src/core/constants/app_strings.dart';
import 'package:quotation_calculation/src/core/constants/sizes.dart';
import 'package:quotation_calculation/src/core/utils/helpers/helper_functions.dart';
import 'package:quotation_calculation/src/core/utils/validators/validations.dart';
import 'package:quotation_calculation/src/core/views/widgets/custom.circular_progress_indicator.dart';
import 'package:quotation_calculation/src/features/home/models/item.model.dart';
import 'package:quotation_calculation/src/features/home/models/quotation.model.dart';
import 'package:quotation_calculation/src/features/home/view_models/Items.view_model.dart';
import 'package:quotation_calculation/src/features/home/view_models/quotations.view_model.dart';

class GeneralScreen extends StatefulWidget {
  final Function(Quotation) onAddPressed;
  final bool isClear;
  const GeneralScreen({super.key, required this.onAddPressed, required this.isClear,});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {

  final _formKey = GlobalKey<FormState>();
  final _qtyController = TextEditingController();
  final _itemController = TextEditingController();
  final _priceController = TextEditingController();
  final _reasonController = TextEditingController();
  final _discountController = TextEditingController();

  List<Item> items = [];
  List<DataRow> rows = [];
  List<Item> filteredItem = [];
  List<Quotation> quotation = [];

  int? quotationNo;
  Item? _selectedItem;
  bool loading = false;
  double netAmount = 0.0;
  bool _showSuggestion = false;

  void _loadItems() async {
    setState(() => loading = true);
    items = await context.read<ItemViewModel>().fetchItems(context);
    _clearTextFields();
    setState(() => loading = false);
  }

  void _clearTextFields(){
    setState(() {
      _selectedItem = items.first;
      _itemController.clear();
      _reasonController.clear();
      _priceController.clear();
      _discountController.text = "0";
      _qtyController.text = "1";
      filteredItem = items;
    });
  }

  Future<int> _fetchQuotationNo() async {
    return context.read<QuotationViewModel>().quotationNo;
  }

  void _filterSearchResults(String query) {
    setState(() {
      filteredItem = items
          .where((item) => item.itemName.toLowerCase().contains(query.toLowerCase()))
          .toList();
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
                    netAmount.toString(),
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
                    TextFormField(
                      controller: _itemController,
                      validator: (value) => validateEmptyField('Item', value),
                      decoration: const InputDecoration(
                        label: Row(
                          children: [
                            Text(AppStrings.itemLabel),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),

                      onTap: () => setState(() => _showSuggestion = true),
                      onChanged: (value) => _filterSearchResults(value),
                    ),
                    if(_showSuggestion)
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(Sizes.sm),
                        child: ListView.builder(
                          itemCount: filteredItem.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: ListTile(
                                title: Text(filteredItem[index].itemName),
                                onTap: ()=> setState(() {
                                  _itemController.text = filteredItem[index].itemName;
                                  _selectedItem = filteredItem[index];
                                  _priceController.text = filteredItem[index].price.toString();
                                  _showSuggestion = false;
                                }),
                              ),
                            );
                          },
                        ),
                      ),

                    ///form
                    const SizedBox(height: Sizes.spaceBtwInputField),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text(AppStrings.reasonLabel),
                      ),
                      onTap: () => setState(() => _showSuggestion = false),
                      validator: (value) => validateEmptyField(AppStrings.reasonLabel, value),
                      controller: _reasonController,
                    ),
                    const SizedBox(height: Sizes.spaceBtwInputField),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text(AppStrings.priceLabel),
                      ),
                      onTap: () => setState(() => _showSuggestion = false),
                      readOnly: true,
                      validator: (value) => validateEmptyField(AppStrings.priceLabel, value),
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
                            onTap: () => setState(() => _showSuggestion = false),
                            onChanged: (value){
                              if(value.isNotEmpty) {
                                int discount = int.parse(value);
                                if (discount < 1) {
                                  _qtyController.text = "1";
                                }
                                _qtyController.selection = TextSelection.fromPosition(
                                  TextPosition(offset: _qtyController.text.length),
                                );
                              }
                            },
                            validator: (value) => validateEmptyField(AppStrings.qtyLabel, value),
                            controller: _qtyController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        const SizedBox(width: Sizes.md),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text('${AppStrings.discountLabel} %'),
                            ),
                            onTap: () => setState(() => _showSuggestion = false),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                            ],
                            onChanged: (value){
                              if(value.isNotEmpty) {
                                double discount = double.parse(value);
                                if (discount < 0) {
                                  _discountController.text = "0";
                                } else if (discount > 100) {
                                  _discountController.text = "100";
                                }
                                _discountController.selection = TextSelection.fromPosition(
                                  TextPosition(offset: _discountController.text.length),
                                );
                              }
                            },
                            controller: _discountController,
                          ),
                        ),
                        const SizedBox(width: Sizes.md),
                        ElevatedButton(
                          child: const Text(AppStrings.addLabel),
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            setState(() => _showSuggestion = false);
                            if (_formKey.currentState!.validate()) {
                              double discount =  double.parse(_discountController.text.trim());
                              int qty =  int.parse(_qtyController.text.trim());
                              double total = (_selectedItem!.price * qty) * (100 - discount) / 100;

                              quotationNo = await _fetchQuotationNo();

                              Quotation tempQtn = Quotation(
                                itemId: _selectedItem!.id!,
                                quotationNo: quotationNo,
                                qty: qty,
                                discount:discount,
                                total: total,
                              );

                              setState(() {
                                quotation.add(tempQtn);
                                netAmount += tempQtn.total;

                              });

                              _buildDataRow(
                                itemName: _selectedItem!.itemName,
                                price: _selectedItem!.price,
                                qty: qty,
                                discount: discount,
                                total: total,
                              );

                              widget.onAddPressed(tempQtn);
                              _clearTextFields();
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: Sizes.spaceBtwItems),
                    ///table
                    DataTable(
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
                      rows: quotation.isEmpty || widget.isClear ? _buildEmptyRow() : rows,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _buildDataRow({
    required String itemName,
    required double price,
    required int qty,
    required double discount,
    required double total,
  }){
      rows.add(
        DataRow(
          cells: <DataCell>[
            _buildDataCell(value: itemName),
            _buildDataCell(value: price.toString()),
            _buildDataCell(value: qty.toString()),
            _buildDataCell(value: discount.toString()),
            _buildDataCell(value: total.toString()),
          ],
        ),
      );
  }

  List<DataRow> _buildEmptyRow({String value = 'No Data'}) {
    setState(() {
      netAmount = 0.0;
      rows = [];
    });
    return [
      DataRow(
        cells: <DataCell>[
          _buildDataCell(),
          _buildDataCell(),
          _buildDataCell(value: value),
          _buildDataCell(),
          _buildDataCell(),
        ],
      ),
    ];
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

  DataCell _buildDataCell({String value = ''}){
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
