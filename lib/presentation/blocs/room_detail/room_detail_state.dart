import 'package:motelhub_flutter/domain/entities/electric.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/presentation/blocs/base/base_state.dart';

abstract class RoomDetailState extends BaseState {
  final int? ownerId;
  final String? ownerName;
  final List<UserEntity>? members;
  final List<ElectricEntity>? electrics;
  const RoomDetailState({this.ownerId, this.members, this.ownerName, this.electrics}) : super();
}

class RoomDetailLoadingFormState extends RoomDetailState {
  const RoomDetailLoadingFormState() : super();
}

class RoomDetailLoadFormStateDone extends RoomDetailState {
  const RoomDetailLoadFormStateDone(
      int? ownerId, String? ownerName, List<UserEntity>? members, List<ElectricEntity>? electrics)
      : super(ownerId: ownerId, ownerName: ownerName, members: members, electrics: electrics);
}

class SubmitFormSuccess extends RoomDetailState {
  const SubmitFormSuccess();
}
