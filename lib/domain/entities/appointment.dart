import 'package:motelhub_flutter/domain/entities/bases/base.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';

class AppointmentEntity extends BaseEntity {
  final String? title;
  final DateTime? startTime;
  final DateTime? endTime;
  final double? duration;
  final bool? isCanceled;
  final UserEntity? creator;
  final UserEntity? participant;
  final int? creatorId;
  final int? participantId;
  final bool? isAccepted;
  final RoomEntity? room;
  final int? roomId;

  const AppointmentEntity(
      {super.id,
      super.createdAt,
      super.isActive,
      super.modifiedAt,
      this.title,
      this.isCanceled,
      this.startTime,
      this.endTime,
      this.duration,
      this.creator,
      this.participant,
      this.creatorId,
      this.participantId,
      this.isAccepted,
      this.room,
      this.roomId})
      : super();
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        createdAt,
        isActive,
        modifiedAt,
        title,
        isCanceled,
        startTime,
        endTime,
        duration,
        creator,
        participant,
        creatorId,
        participantId,
        isAccepted,
        room,
        roomId
      ];
  
  static List<AppointmentEntity> getFakeData() {
    List<AppointmentEntity> result = [];
    for(int i = 1; i <= 10; i++){
      result.add(AppointmentEntity(id: i, createdAt: DateTime.now(), isActive: true, modifiedAt: DateTime.now(), title: "Appointment $i",
      duration: 90,
      creator: UserEntity.getFakeData().firstWhere((element) => element.id == i),
      creatorId: i,
      participant: UserEntity.getFakeData().firstWhere((element) => element.id == i+1),
      participantId: i+1,
      isAccepted: i%2 == 0 ? true : false,
      room: RoomEntity.getFakeData().firstWhere((element) => element.id == i),
      roomId: i),);
    }
    return result;
  }
}
