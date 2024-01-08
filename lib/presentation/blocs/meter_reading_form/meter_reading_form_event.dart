abstract class MeterReadingFormEvent {
  final int? meterReadingId;
  const MeterReadingFormEvent({this.meterReadingId});
}

class InitFormEvent extends MeterReadingFormEvent{
  const InitFormEvent(int? meterReadingId) : super(meterReadingId: meterReadingId);
}

class SubmitFormEvent extends MeterReadingFormEvent {
  const SubmitFormEvent() : super();
}