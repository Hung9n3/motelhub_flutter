import 'package:dio/dio.dart';

class BaseBillFormState {
  final String? errorMessage;
  const BaseBillFormState({this.errorMessage});
}

class BillFormDone extends BaseBillFormState{
  const BillFormDone() : super();
}

class BillFormLoading extends BaseBillFormState{
  const BillFormLoading() : super();
}

class BillFormError extends BaseBillFormState {
  const BillFormError(String? errorMessage) : super(errorMessage: errorMessage);
}