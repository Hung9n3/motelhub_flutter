import 'package:motelhub_flutter/presentation/blocs/base/base_state.dart';

abstract class AddAreaState extends BaseState{
  const AddAreaState() : super();
}

class AddAreaInitState extends AddAreaState{
const AddAreaInitState();
}

class AddAreaStateDone extends AddAreaState{
const AddAreaStateDone();
}