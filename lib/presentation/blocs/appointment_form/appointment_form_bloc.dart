import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/domain/repositories/appointment_repository_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/appointment_form/appointment_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/appointment_form/appointment_form_state.dart';

class AppointmentFormBloc extends Bloc<AppointmentFormEvent, AppointmentFormState> {
  final IAppointmentRepository _appointmentRepository;
  AppointmentFormBloc(this._appointmentRepository) : super(const AppointmentFormLoadingState()){
    
  }
}