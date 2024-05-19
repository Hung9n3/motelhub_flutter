import 'package:dio/dio.dart';

class AppointmentFormState {
  final bool? isCanceled;
  final bool? isAccepted;
  final DioError? error;
  final String? alert;
  const AppointmentFormState({this.error, this.isCanceled, this.alert, this.isAccepted});
}

class AppointmentFormLoadingState extends AppointmentFormState{
  const AppointmentFormLoadingState() : super();
}

class AppointmentFormDoneState extends AppointmentFormState{
  const AppointmentFormDoneState(bool? isAccepted, bool? isCanceled) : super(isAccepted: isAccepted, isCanceled: isCanceled);
}

class AppointmentFormErrorState extends AppointmentFormState{
  const AppointmentFormErrorState(DioError? error) : super(error: error);
}

class AppointmentFormChangeDateDone extends AppointmentFormState {
  const AppointmentFormChangeDateDone(bool? isCanceled) : super(isCanceled: isCanceled);
}

class AppointmentFormValidateFail extends AppointmentFormState {
  const AppointmentFormValidateFail(String? alert) : super(alert: alert);
}