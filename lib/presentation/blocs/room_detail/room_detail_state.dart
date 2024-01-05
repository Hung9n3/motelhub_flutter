import 'package:motelhub_flutter/presentation/blocs/base/base_state.dart';

abstract class RoomDetailState extends BaseState {
  
  const RoomDetailState() : super();
}

class RoomDetailLoadingFormState extends RoomDetailState {
  const RoomDetailLoadingFormState() : super();
}

class RoomDetailLoadFormStateDone extends RoomDetailState {
  const RoomDetailLoadFormStateDone() : super();
}

class SubmitFormSuccess extends RoomDetailState {
  const SubmitFormSuccess();
}