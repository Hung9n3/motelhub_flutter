import 'package:flutter/material.dart';
import 'package:motelhub_flutter/domain/entities/appointment.dart';
import 'package:motelhub_flutter/presentation/blocs/base/base_state.dart';

abstract class MyAppointmentState {
  final List<AppointmentEntity>? data;
  final Exception? error;

  const MyAppointmentState({this.data, this.error});
}

class MyAppointmentDoneState extends MyAppointmentState {
  const MyAppointmentDoneState(List<AppointmentEntity> data) : super(data: data);
}

class MyAppointmentLoadingState extends MyAppointmentState {
  const MyAppointmentLoadingState() : super();
}

class MyAppointmentErrorState extends MyAppointmentState {
  const MyAppointmentErrorState(Exception error) : super(error: error);
} 
