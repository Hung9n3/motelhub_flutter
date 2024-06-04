import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/constants/constants.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/appointment.dart';
import 'package:motelhub_flutter/domain/repositories/appointment_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/appointment_form/appointment_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/appointment_form/appointment_form_state.dart';

class AppointmentFormBloc
    extends Bloc<AppointmentFormEvent, AppointmentFormState> {
  final IAppointmentRepository _appointmentRepository;
  final IRoomRepository _roomRepository;
  final IAreaRepository _areaRepository;
  final ITokenHandler _tokenHandler;
  AppointmentFormBloc(
      this._appointmentRepository, this._roomRepository, this._areaRepository, this._tokenHandler)
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
  int? duration = 0;
  int? participantId;
  int? roomId;
  String? roomName;
  String? participantName;
  bool isCanceled = false;
  bool isAccepted = false;
  int? currentUserId;
  bool isCreator = false;
  bool isOver = false;

  _getData(AppointmentFormInitEvent event,
      Emitter<AppointmentFormState> emit) async {
    try {
      currentUserId = int.tryParse(await _tokenHandler.getByKey(currentUserIdKey));
      roomId = event.roomId;
      var room = (await _roomRepository.getById(roomId!)).data;
      if (room != null) {
        var area = (await _areaRepository.getById(room.areaId!));
        roomName = room.name;
        participantName = room.ownerName;
        participantId = area.data?.hostId;
      }

      if (event.appointmentId == null) {
        creatorId = currentUserId;
        isCreator = true;
        emit(const AppointmentFormDoneState(false, false));
        return;
      }
      var dataState =
          await _appointmentRepository.getById(event.appointmentId!);
      var data = dataState.data;
      if (dataState is DataSuccess && dataState.data != null) {
        title = data!.title;
        creatorId = data.creatorId;
        isCanceled = data.isCanceled ?? false;
        startDate = data.startTime?.toLocal();
        startTime = startDate == null
            ? TimeOfDay.now()
            : TimeOfDay.fromDateTime(startDate!);
        duration = data.duration;
        isAccepted = data.isAccepted ?? false;
        participantName = data.participant?.name;

        if(currentUserId != creatorId) {
          isCreator = false;
        }
        if(startDate != null && startDate!.compareTo(DateTime.now()) < 0) { 
          isOver = true;
        } 
      }
      if(dataState is DataFailed) {
        emit(AppointmentFormErrorState(dataState.message));
      }
      emit(AppointmentFormDoneState(isAccepted, isCanceled));
    } on Error catch (e) {
      emit(AppointmentFormErrorState(e.toString()));
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

  _submit(AppointmentFormSubmitEvent event,
      Emitter<AppointmentFormState> emit) async {
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
            .add(Duration(hours: startTime!.hour, minutes: startTime!.minute))
            .toUtc());
    print(appointment);
    var result = await _appointmentRepository.save(appointment);
    if(result is DataSuccess) {
      emit(const AppointmentFormSubmitDone());
    }
    else {
      emit(AppointmentFormErrorState(result.message));
    }
    //await _appointmentRepository.save(appointment);
  }
}
