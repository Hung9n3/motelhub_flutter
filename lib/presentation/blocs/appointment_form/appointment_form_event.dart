import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppointmentFormEvent {
  final int? appointmentId;
  final DateTime? startDate;
  final TimeOfDay? startTime; 
  final int? duration;
  final int? creatorId;
  final int? participantId;
  final int? roomId;
  final bool? isCanceled;
  final bool? isAccepted;
  
  const AppointmentFormEvent(
      {this.appointmentId,
      this.startDate,
      this.startTime,
      this.isCanceled,
      this.isAccepted,
      this.duration,
      this.creatorId,
      this.roomId,
      this.participantId});
}

class AppointmentFormInitEvent extends AppointmentFormEvent {
  const AppointmentFormInitEvent(int? appointmentId, int? roomId)
      : super(appointmentId: appointmentId, roomId: roomId);
}

class AppointmentFormSubmitEvent extends AppointmentFormEvent {
  const AppointmentFormSubmitEvent(
    int? appointmentId,
    int? duration,
  ) : super(appointmentId: appointmentId, duration: duration);
}

  class AppointmentFormIsCancelChangeEvent extends AppointmentFormEvent {
    const AppointmentFormIsCancelChangeEvent(bool? isCanceled) : super(isCanceled: isCanceled);
  }

  class AppointmentFormIsAcceptedChangeEvent extends AppointmentFormEvent {
    const AppointmentFormIsAcceptedChangeEvent(bool? isAccepted) : super(isAccepted: isAccepted);
  }

  class AppointmentFormChangeStartDateEvent extends AppointmentFormEvent {
  const AppointmentFormChangeStartDateEvent(DateTime? selectedDate) : super(startDate: selectedDate);
}

class AppointmentFormChangeStartTimeEvent extends AppointmentFormEvent {
  const AppointmentFormChangeStartTimeEvent(TimeOfDay? selectedTime) : super(startTime: selectedTime);
}
