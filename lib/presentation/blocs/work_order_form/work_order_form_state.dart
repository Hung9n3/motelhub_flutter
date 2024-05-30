import 'package:dio/dio.dart';

class WorkOrderFormState {
  final String? error;
  final bool? isCustomerPay;
  final bool? isOpen;
  const WorkOrderFormState({this.error, this.isCustomerPay, this.isOpen});
}

class WorkOrderFormLoadingState extends WorkOrderFormState {
  const WorkOrderFormLoadingState() : super();
}

class WorkOrderFormDoneState extends WorkOrderFormState {
  const WorkOrderFormDoneState(bool? isCustomerPay, bool? isOpen) : super(isCustomerPay: isCustomerPay, isOpen: isOpen);
}

class WorkOrderFormErrorState extends WorkOrderFormState {
  const WorkOrderFormErrorState(String? error) : super(error: error);
}