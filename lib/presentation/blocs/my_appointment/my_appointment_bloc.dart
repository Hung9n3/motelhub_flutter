import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/constants/constants.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/appointment.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/domain/repositories/appointment_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/my_appointment/my_appointment_event.dart';
import 'package:motelhub_flutter/presentation/blocs/my_appointment/my_appointment_state.dart';

class MyAppointmentBloc extends Bloc<MyAppointmentEvent, MyAppointmentState> {
  final IAppointmentRepository _appointmentRepository;
  final ITokenHandler _tokenHandler;
  MyAppointmentBloc(this._appointmentRepository, this._tokenHandler)
      : super(const MyAppointmentLoadingState()) {
    on<MyAppointmentInitEvent>(getAppointments);
  }

  getAppointments(
      MyAppointmentInitEvent event, Emitter<MyAppointmentState> emit) async {
    try {
      var currentUserId =
          int.tryParse(await _tokenHandler.getByKey(currentUserIdKey));
      if (currentUserId == null) {
        return;
      }
      var dataState = await _appointmentRepository.getByUser(currentUserId);
      if (dataState is DataSuccess) {
        emit(MyAppointmentDoneState(dataState.data ?? []));
      } else {
        emit(MyAppointmentErrorState(dataState.message));
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  acceptAppointment(MyAppointmentAcceptEvent event, Emitter<MyAppointmentState> emit) async{
    try {
      if(event.id == null || event.id == 0) {
        return;
      }
      var dataState = await _appointmentRepository.getById(event.id!);
      if(dataState is DataSuccess) {
        var data = dataState.data!;
        var appointment = AppointmentEntity(
          id: data.id,
          creatorId: data.creatorId,
          participantId: data.participantId,
          startTime: data.startTime,
          duration: data.duration,
          roomId: event.roomId,
          isAccepted: true,
          isActive: true,
          isCanceled: data.isCanceled,
        );
      }
    } on Exception catch (e) {
      
    }
  }

  cancelAppointment(MyAppointmentRejectEvent event, Emitter<MyAppointmentState> emit) async{
    
  }
}
