class AppointmentFormEvent {
  final int? appointmentId;
  final DateTime? startTime;
  final int? duration;
  final int? creatorId;
  final int? participantId;
  final int? roomId;
  final String? title;
  const AppointmentFormEvent(
      {this.appointmentId,
      this.startTime,
      this.duration,
      this.creatorId,
      this.roomId,
      this.participantId,
      this.title});
}

class AppointmentFormInitEvent extends AppointmentFormEvent {
  const AppointmentFormInitEvent(int? appointmentId)
      : super(appointmentId: appointmentId);
}

class AppointmentFormSubmitEvent extends AppointmentFormEvent {
  const AppointmentFormSubmitEvent(
    int? appointmentId,
    DateTime? startTime,
    int? duration,
    int? creatorId,
    int? participantId,
    int? roomId,
    String? title,
  ) : super();
}
