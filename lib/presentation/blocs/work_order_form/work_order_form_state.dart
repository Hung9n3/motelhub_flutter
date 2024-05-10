import 'package:dio/dio.dart';

class WorkOrderFormState {
  final DioError? error;
  const WorkOrderFormState({this.error});
}

class WorkOrderFormLoadingState extends WorkOrderFormState {
  const WorkOrderFormLoadingState() : super();
}

class WorkOrderFormDoneState extends WorkOrderFormState {
  const WorkOrderFormDoneState() : super();
}

class WorkOrderFormErrorState extends WorkOrderFormState {
  const WorkOrderFormErrorState(DioError? error) : super(error: error);
}