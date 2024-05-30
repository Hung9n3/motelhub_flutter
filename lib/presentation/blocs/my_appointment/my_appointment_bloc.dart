import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/repositories/appointment_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/my_appointment/my_appointment_event.dart';
import 'package:motelhub_flutter/presentation/blocs/my_appointment/my_appointment_state.dart';

class MyAppointmentBloc extends Bloc<MyAppointmentEvent, MyAppointmentState> {
  final IAppointmentRepository _appointmentRepository;
  final ITokenHandler _tokenHandler;
  MyAppointmentBloc(this._appointmentRepository, this._tokenHandler) : super(const MyAppointmentLoadingState()){
    on<MyAppointmentInitEvent>(getAppointments);
  }

  getAppointments(MyAppointmentInitEvent event, Emitter<MyAppointmentState> emit) async {
    try {
  var dataState = await this._appointmentRepository.getByUser(1);
  if(dataState is DataSuccess) {
      emit(MyAppointmentDoneState(dataState.data ?? []));
    }
    else {
      emit(MyAppointmentErrorState(dataState.message));
    }
} on Exception catch (e) {
  print(e);
}
  }
}
