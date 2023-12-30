import 'package:motelhub_flutter/presentation/blocs/base/base_state.dart';

abstract class AddAreaState extends BaseState {
  String? name;
  String? address;
  AddAreaState({this.name, this.address}) : super();
}

class AddAreaInitState extends AddAreaState {
  AddAreaInitState();
}

class AddAreaLoadFormDoneState extends AddAreaState {
  AddAreaLoadFormDoneState();
}
