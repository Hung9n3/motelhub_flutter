import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/repositories/appointment_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/appointment_form/appointment_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/appointment_form/appointment_form_state.dart';

class AppointmentFormBloc extends Bloc<AppointmentFormEvent, AppointmentFormState> {
  final IAppointmentRepository _appointmentRepository;
  final IRoomRepository _roomRepository;
  AppointmentFormBloc(this._appointmentRepository, this._roomRepository) : super(const AppointmentFormLoadingState()){
    
  }

  String? title;
  DateTime? startTime;
  double? duration;
  bool? isAccepted;
  int? participantId;
  int? roomId;
  String? roomName;
  String? participantName;
  bool? isCanceled;

  _getData(AppointmentFormInitEvent event, Emitter<AppointmentFormState> emit) async {
    try {
      roomId = event.roomId;
      var room = (await _roomRepository.getById(roomId!)).data;
      roomName = room!.name;
      participantName = room.ownerName;
      participantId = room.ownerId;

      if(event.appointmentId == null) {
        emit(const AppointmentFormDoneState());
        return;
      }
      var dataState = await _appointmentRepository.getById(event.appointmentId!);
      var data = dataState.data;
      if(dataState is DataSuccess && dataState.data != null) {
        title = data!.title;
        startTime = data.startTime;
        duration = data.duration;
        isAccepted = data.isAccepted;
        isCanceled = data.isCanceled;
      }
    } on Error catch (e) {
      print(e);
    }
  }
}