import 'package:dio/dio.dart';

class AppointmentFormState {
  final DioError? error;
  const AppointmentFormState({this.error});
}

class AppointmentFormLoadingState extends AppointmentFormState{
  const AppointmentFormLoadingState() : super();
}

class AppointmentFormDoneState extends AppointmentFormState{
  const AppointmentFormDoneState();
}

class AppointmentFormErrorState extends AppointmentFormState{
  const AppointmentFormErrorState(DioError? error) : super(error: error);
}