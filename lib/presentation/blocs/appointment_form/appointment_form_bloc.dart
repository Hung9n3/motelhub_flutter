import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/appointment.dart';
import 'package:motelhub_flutter/domain/repositories/appointment_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/appointment_form/appointment_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/appointment_form/appointment_form_state.dart';

class AppointmentFormBloc
    extends Bloc<AppointmentFormEvent, AppointmentFormState> {
  final IAppointmentRepository _appointmentRepository;
  final IRoomRepository _roomRepository;
  AppointmentFormBloc(this._appointmentRepository, this._roomRepository)
      : super(const AppointmentFormLoadingState()) {
    on<AppointmentFormInitEvent>(_getData);
    on<AppointmentFormChangeStartDateEvent>(_changeDate);
    on<AppointmentFormChangeStartTimeEvent>(_changeTime);
    on<AppointmentFormSubmitEvent>(_submit);
    on<AppointmentFormIsAcceptedChangeEvent>(_changeSwitch);
    on<AppointmentFormIsCancelChangeEvent>(_changeSwitch);
  }

  int? creatorId;
  String? title;
  DateTime? startDate;
  TimeOfDay? startTime;
  int? duration;
  int? participantId;
  int? roomId;
  String? roomName;
  String? participantName;
  bool? isCanceled;
  bool? isAccepted;
  int? currentUserId;

  _getData(AppointmentFormInitEvent event,
      Emitter<AppointmentFormState> emit) async {
    try {
      currentUserId = 0;
      roomId = event.roomId;
      var room = (await _roomRepository.getById(roomId!)).data;
      roomName = room!.name;
      participantName = room.ownerName;
      participantId = room.customerId;

      if (event.appointmentId == null) {
        creatorId = currentUserId;
        emit(const AppointmentFormDoneState(false, false));
        return;
      }
      var dataState =
          await _appointmentRepository.getById(event.appointmentId!);
      var data = dataState.data;
      if (dataState is DataSuccess && dataState.data != null) {
        title = data!.title;
        creatorId = data.creatorId;
        isCanceled = data.isCanceled;
        startDate = data.startTime?.toLocal();
        startTime = startDate == null
            ? TimeOfDay.now()
            : TimeOfDay.fromDateTime(startDate!);
        duration = data.duration;
        isAccepted = data.isAccepted;
        roomName = data.room?.name;
        participantName = data.participant?.name;
      }
      emit(AppointmentFormDoneState(isAccepted, isCanceled));
    } on Error catch (e) {
      print(e);
    }
  }

  _changeDate(AppointmentFormChangeStartDateEvent event,
      Emitter<AppointmentFormState> emit) {
    if (event.startDate != null) {
      startDate = event.startDate;
    }
    emit(AppointmentFormChangeDateDone(isCanceled));
  }

  _changeTime(AppointmentFormChangeStartTimeEvent event,
      Emitter<AppointmentFormState> emit) {
    if (event.startTime != null) {
      startTime = event.startTime!;
    }
    emit(AppointmentFormChangeDateDone(isCanceled));
  }

  _changeSwitch(
      AppointmentFormEvent event, Emitter<AppointmentFormState> emit) {
    if (event is AppointmentFormIsCancelChangeEvent) {
      isCanceled = event.isCanceled ?? false;
      emit(AppointmentFormDoneState(isAccepted, isCanceled));
    }
    if (event is AppointmentFormIsAcceptedChangeEvent) {
      isAccepted = event.isAccepted ?? false;
      emit(AppointmentFormDoneState(isAccepted, isCanceled));
    }
  }

  _submit(
      AppointmentFormSubmitEvent event, Emitter<AppointmentFormState> emit) async {
    if (startDate == null || startTime == null) {
      emit(const AppointmentFormValidateFail(
          'Start time, Duration and Title can not be empty'));
      return;
    }

    var appointment = AppointmentEntity(
        id: event.appointmentId ?? 0,
        creatorId: creatorId,
        participantId: participantId,
        isAccepted: isAccepted,
        isCanceled: isCanceled,
        duration: event.duration,
        roomId: roomId,
        startTime: startDate!
            .add(Duration(hours: startTime!.hour, minutes: startTime!.minute)).toUtc()
            );
            print(appointment);
    //await _appointmentRepository.save(appointment);
  }
}
