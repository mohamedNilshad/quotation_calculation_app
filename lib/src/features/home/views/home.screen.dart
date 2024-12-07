import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotation_calculation/src/core/constants/app_colors.dart';
import 'package:quotation_calculation/src/core/constants/icon_strings.dart';
import 'package:quotation_calculation/src/core/constants/sizes.dart';
import 'package:quotation_calculation/src/core/utils/formatters/formatter.dart';
import 'package:quotation_calculation/src/core/views/widgets/custom.circular_progress_indicator.dart';
import 'package:quotation_calculation/src/core/views/widgets/svg_icon_builder.widget.dart';
import 'package:quotation_calculation/src/features/home/models/quotation.model.dart';
import 'package:quotation_calculation/src/features/home/view_models/quotations.view_model.dart';
import 'package:quotation_calculation/src/features/home/views/general.screen.dart';
import 'package:quotation_calculation/src/features/home/views/items.screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  final _tabs = [const Tab(text: 'General'), const Tab(text: 'Items')];
  final List<String> items = ['Auckland Offices', 'Office 2', 'Office 3', 'Office 4', 'Office 5'];

  bool clear = true;
  bool loading = false;
  String? _selectedItem;
  List<Quotation> quotations = [];

  void _updateList(Quotation quotation){
    setState(() {
      quotations.add(quotation);
      clear = false;
    });
  }

  void _saveQuotations(List<Quotation> quotationsList) async {
    setState(() => loading = true);
    await context.read<QuotationViewModel>().addQuotations(context, quotationsList);
    if(mounted) {
      await context.read<QuotationViewModel>().fetchQuotationNo(context);
    }
    if(mounted) {
      await context.read<QuotationViewModel>().fetchQuotations(context);
    }
    setState(() {
      clear = true;
      quotations = [];
      loading = false;
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    setState(() => _selectedItem = items.first);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.inventory_rounded),
        titleSpacing: 0,
        title: const Text('Quotation'),
        actions: [
          const CSvgIconBuilder(
            icon: IconStrings.shareIcon,
            color: AppColors.white,
          ),
          IconButton(
              onPressed: quotations.isEmpty ? null : ()=>_saveQuotations(quotations),
              icon: loading ? const CCircularProgressIndicator(color: AppColors.white) :
              CSvgIconBuilder(
                icon: IconStrings.checkmarkIcon,
                color: quotations.isEmpty ? AppColors.darkGrey: AppColors.white,
              )
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.md),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    value: _selectedItem,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold
                    ),
                    underline: const SizedBox(),
                    onChanged: (String? newValue) {
                      setState(() => _selectedItem = newValue);
                    },
                    items: items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Text(
                    Formatter.formatDate(DateTime.now()),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: kToolbarHeight,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(Sizes.sm),
                border: Border.all(color: AppColors.primary, width: 3),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(Sizes.sm/2),
                  color: AppColors.primary,
                ),
                dividerColor: Colors.transparent,
                labelStyle: Theme.of(context).textTheme.titleLarge,
                labelColor: AppColors.white,
                unselectedLabelColor: AppColors.primary,
                tabs: _tabs,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  GeneralScreen(onAddPressed: _updateList, isClear: clear),
                  const ItemsScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
