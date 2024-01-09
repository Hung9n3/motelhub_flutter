import 'package:motelhub_flutter/core/enums/option_sets.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';

abstract class MeterReadingFormEvent {
  final int? meterReadingId;
  final MeterReadingType? type;
  final List<PhotoEntity>? photos;
  final String? textValue;
  const MeterReadingFormEvent({this.meterReadingId, this.type, this.photos, this.textValue});
}

class InitFormEvent extends MeterReadingFormEvent {
  const InitFormEvent(int? meterReadingId, MeterReadingType? type)
      : super(meterReadingId: meterReadingId, type: type);
}

class SubmitFormEvent extends MeterReadingFormEvent {
  const SubmitFormEvent(
      MeterReadingType? type, List<PhotoEntity>? photos)
      : super(type: type, photos: photos);
}

class ChangeNameEvent extends MeterReadingFormEvent {
  const ChangeNameEvent(String? textValue) : super(textValue: textValue);
}

class ChangeLastMonthEvent extends MeterReadingFormEvent {
  const ChangeLastMonthEvent(String? textValue) : super(textValue: textValue);
}

class ChangeThisMonthEvent extends MeterReadingFormEvent {
  const ChangeThisMonthEvent(String? textValue) : super(textValue: textValue);
}

class ChangePriceEvent extends MeterReadingFormEvent {
  const ChangePriceEvent(String? textValue) : super(textValue: textValue);
}