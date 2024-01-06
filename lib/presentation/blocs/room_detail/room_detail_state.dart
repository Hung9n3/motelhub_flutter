import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/presentation/blocs/base/base_state.dart';

abstract class RoomDetailState extends BaseState {
  final int? ownerId;
  final String? ownerName;
  final List<UserEntity>? members;
  const RoomDetailState({this.ownerId, this.members, this.ownerName}) : super();
}

class RoomDetailLoadingFormState extends RoomDetailState {
  const RoomDetailLoadingFormState() : super();
}

class RoomDetailLoadFormStateDone extends RoomDetailState {
  const RoomDetailLoadFormStateDone(
      int? ownerId, String? ownerName, List<UserEntity>? members)
      : super(ownerId: ownerId, ownerName: ownerName, members: members);
}

class SubmitFormSuccess extends RoomDetailState {
  const SubmitFormSuccess();
}
