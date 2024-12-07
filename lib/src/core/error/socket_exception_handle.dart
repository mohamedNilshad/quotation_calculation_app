import 'dart:io';

import 'package:quotation_calculation/src/core/error/exception.dart';

void throwWhenSocketException(SocketException e) {
  var exception = FailureException("please try again!");
  if (Platform.isAndroid) {
    if (e.osError!.errorCode == 110) {
      throw TimeoutConnectionException("Failed to establish proper connection!");
    }
  } else {
    if (e.osError!.errorCode == 60 || e.osError!.errorCode == 61) {
      throw TimeoutConnectionException("Failed to establish proper connection!");
    }
  }
  throw exception;
}