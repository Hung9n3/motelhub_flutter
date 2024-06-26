import 'package:motelhub_flutter/domain/entities/bases/base.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';

class AppointmentEntity extends BaseEntity {
   String? title;
   DateTime? startTime;
   DateTime? endTime;
   int? duration;
   bool? isCanceled;
   bool? isAccepted;
   int? creatorId;
   int? participantId;
   int? roomId;
   UserEntity? creator;
   UserEntity? participant;
   RoomEntity? room;

  AppointmentEntity({
    super.id,
    super.createdAt,
    super.isActive,
    super.modifiedAt,
    this.title,
    this.isCanceled,
    this.startTime,
    this.endTime,
    this.duration,
    this.creatorId,
    this.participantId,
    this.isAccepted,
    this.roomId,
    this.creator,
    this.participant,
    this.room,
  }) : super();
  
  factory AppointmentEntity.fromJson(Map<String, dynamic> map) {
    return AppointmentEntity(
      id: map['id'] ?? 0,
      roomId: map['roomId'] ?? 0,
      title: map['title'] ?? '',
      isCanceled: map['isCanceled'] ?? false,
      startTime: DateTime.parse(map['startTime']).toLocal(),
      duration: map['duration'] ?? 0,
      creatorId: map['creatorId'] ?? 0,
      participantId: map['participantId'] ?? 0,
      isAccepted: map['isAccepted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id ?? '0',
        'roomId': roomId == 0 ? null : roomId,
        'title': title ?? '',
        'isCanceled': isCanceled ?? 'false',
        'startTime': startTime?.toUtc(),
        'duration': duration ?? '0',
        'creatorId': creatorId == 0 ? null : creatorId,
        'participantId': participantId == 0 ? null : participantId,
        'isAccepted': isAccepted ?? 'false',
      };

  static List<AppointmentEntity> getFakeData() {
    List<AppointmentEntity> result = [];
    for (int i = 1; i <= 10; i++) {
      result.add(
        AppointmentEntity(
            id: i,
            createdAt: DateTime.now(),
            isActive: true,
            modifiedAt: DateTime.now(),
            title: "Appointment $i",
            duration: 90,
            creator: UserEntity.getFakeData()
                .firstWhere((element) => element.id == i),
            creatorId: i,
            participant: UserEntity.getFakeData()
                .firstWhere((element) => element.id == i + 1),
            participantId: i + 1,
            isAccepted: i % 2 == 0 ? true : false,
            room: RoomEntity.getFakeData()
                .firstWhere((element) => element.id == i),
            roomId: i),
      );
    }
    return result;
  }

  static List<AppointmentEntity> appointments = [];
}
