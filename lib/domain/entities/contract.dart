import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/entities/bill.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';

class ContractEntity extends Equatable {
  final int? id;
  final int? customerId;
  final String? name;
  final int? roomId;
  final int? hostId;
  final double? roomPrice;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? cancelDate;
  final UserEntity? owner;
  final RoomEntity? roomEntity;
  final List<BillEntity>? bills;

  const ContractEntity(
      {this.id,
      this.hostId,
      this.customerId,
      this.roomId,
      this.name,
      this.roomPrice,
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
        customerId,
        roomId,
        bills,
        owner,
        roomEntity,
        startDate,
        endDate,
        cancelDate
      ];

  factory ContractEntity.fromJson(Map<String, dynamic> map) {
    return ContractEntity(
      id: map['id'] ?? 0,
      roomId: map['roomId'] ?? 0,
      customerId: map['customerId'] ?? 0,
      roomPrice: map['roomPrice'] ?? 0.0,
      name: map['name'] ?? '',
      startDate: map['startDate'],
      endDate: map['endDate'],
      cancelDate: map['cancelDate'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id ?? '0',
      'roomId': roomId ?? '0',
      'customerId': customerId ?? 0,
      'roomPrice': roomPrice ?? '0.0',
      'name': name ?? '',
      'startDate': startDate?.toUtc(),
      'endDate': endDate?.toUtc(),
      'cancelDate': cancelDate?.toUtc(),
  };

  static List<ContractEntity> getFakeData() {
    var result = <ContractEntity>[];
    for (int i = 1; i <= 5; i++) {
      result.add(ContractEntity(
          id: i,
          roomId: i,
          customerId: i,
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
