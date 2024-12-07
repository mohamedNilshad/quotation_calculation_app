
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:quotation_calculation/src/app/injection_container.dart';
import 'package:quotation_calculation/src/core/constants/app_colors.dart';
import 'package:quotation_calculation/src/core/constants/app_strings.dart';
import 'package:quotation_calculation/src/core/error/failures.dart';
import 'package:quotation_calculation/src/core/views/widgets/custom.snackbar.dart';
import 'package:quotation_calculation/src/features/home/data/repositories/quotation.repository.dart';
import 'package:quotation_calculation/src/features/home/models/quotation.model.dart';

class QuotationViewModel with ChangeNotifier{
  final QuotationRepository _quotationRepository = sl<QuotationRepository>();

  late int _lastSavedQuotationNo;

  int get quotationNo => _lastSavedQuotationNo;

  Future<void> fetchQuotationNo(BuildContext context) async {
    try {
      Either<Failure, int> result = await _quotationRepository.getQuotationNo();
      return result.fold((l) {
        customSnackBar(context, l.message);
      }, (int number) {
        _lastSavedQuotationNo = number;
        notifyListeners();
      });
    } catch (error) {
      customSnackBar(context, AppStrings.appUnrecognisedError);
    }
  }

  Future<void> fetchQuotations(BuildContext context) async {
    try {
      Either<Failure, List<Quotation>> result = await _quotationRepository.getQuotations();
      return result.fold((l) {
        customSnackBar(context, l.message);
      }, (List<Quotation> qList) {
        for(var qItem in qList){
          print(qItem.toMap());
        }
      });
    } catch (error) {
      customSnackBar(context, AppStrings.appUnrecognisedError);
    }
  }

  Future<void> addQuotations(BuildContext context, List<Quotation> quotations) async {
    // notifyListeners();
    try {
      Either<Failure, bool> result = await _quotationRepository.addQuotation(quotations: quotations);
      return result.fold((l) {
        customSnackBar(context, l.message);
      }, (bool r) {
        if(r) {
          customSnackBar(context, "Quotation Saved Successfully", backgroundColor: AppColors.success);
        }else{
          customSnackBar(context, "Quotation Saved Failed!!");
        }

      });
    } catch (error) {
      customSnackBar(context, AppStrings.appUnrecognisedError);
    }
  }
}