import 'package:motelhub_flutter/presentation/blocs/base/base_state.dart';

abstract class MeterReadingFormState extends BaseState {
  const MeterReadingFormState();
}

class MeterReadingFormLoading extends MeterReadingFormState {
  const MeterReadingFormLoading();
}

class MeterReadingChangingField extends MeterReadingFormState {
  const MeterReadingChangingField();
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
