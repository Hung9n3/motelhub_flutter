import 'package:motelhub_flutter/presentation/blocs/base/base_state.dart';

abstract class MeterReadingFormState extends BaseState {
  final double? value;
  final double? total;
  const MeterReadingFormState({this.value, this.total});
}

class MeterReadingFormLoading extends MeterReadingFormState {
  const MeterReadingFormLoading();
}

class MeterReadingFormUpdateFieldDone extends MeterReadingFormState {
  const MeterReadingFormUpdateFieldDone();
}

class MeterReadingFormLoadDone extends MeterReadingFormState {
  const MeterReadingFormLoadDone();
}

class MeterReadingFormNotFound extends MeterReadingFormState {
  const MeterReadingFormNotFound();
}

class SubmitFormSuccess extends MeterReadingFormState {
  const SubmitFormSuccess();
}
