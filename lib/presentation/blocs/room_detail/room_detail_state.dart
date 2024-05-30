import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/presentation/blocs/base/base_state.dart';

abstract class RoomDetailState extends BaseState {
  final int? ownerId;
  final String? ownerName;
  const RoomDetailState(
      {this.ownerId, this.ownerName})
      : super();
}

class RoomDetailLoadingFormState extends RoomDetailState {
  const RoomDetailLoadingFormState() : super();
}

class RoomDetailLoadFormStateDone extends RoomDetailState {
  const RoomDetailLoadFormStateDone(
      int? ownerId,
      String? ownerName)
      : super(
            ownerId: ownerId,
            ownerName: ownerName,
            );
}

class SubmitFormSuccess extends RoomDetailState {
  const SubmitFormSuccess();
}
