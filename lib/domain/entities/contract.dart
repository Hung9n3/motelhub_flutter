import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/entities/room_bill.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';

class ContractEntity extends Equatable {
  final int? id;
  final int? ownerId;
  final int? roomId;
  final hostId;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? cancelDate;
  final UserEntity? owner;
  final RoomEntity? roomEntity;
  final List<RoomBillEntity>? bills;

  const ContractEntity(
      {this.id,
      this.hostId,
      this.ownerId,
      this.roomId,
      this.bills = const [],
      this.owner,
      this.roomEntity,
      this.startDate,
      this.endDate,
      this.cancelDate});
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        ownerId,
        roomId,
        bills,
        owner,
        roomEntity,
        startDate,
        endDate,
        cancelDate
      ];

  static List<ContractEntity> getFakeData() {
    var result = <ContractEntity>[];
    for (int i = 1; i <= 5; i++) {
      result.add(ContractEntity(
          id: i,
          roomId: i,
          ownerId: i,
          owner: UserEntity.getFakeData()
              .where((element) => element.id == i)
              .firstOrNull,
          startDate: DateTime.now().add(const Duration(days: 2)),
          endDate: DateTime.now().add(const Duration(days: 365)),
          cancelDate: DateTime.now().add(const Duration(days: 200))
          ));
    }
    return result;
  }
}
