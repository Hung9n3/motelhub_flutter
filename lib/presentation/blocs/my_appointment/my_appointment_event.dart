abstract class MyAppointmentEvent {
  final int? id;
  final int? roomId;
  const MyAppointmentEvent({this.id, this.roomId});
}

class MyAppointmentInitEvent extends MyAppointmentEvent{
  const MyAppointmentInitEvent() : super();
}

class MyAppointmentAcceptEvent extends MyAppointmentEvent {
  const MyAppointmentAcceptEvent(int? id, int? roomId) : super(id: id, roomId: roomId);
}

class MyAppointmentRejectEvent extends MyAppointmentEvent {
  const MyAppointmentRejectEvent(int? id, int? roomId) : super(id: id, roomId: roomId);
}