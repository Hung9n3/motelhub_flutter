import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';

class RoomBillEntity extends Equatable {
  final int? id;
  final int? hostId;
  final int? contractId;
  final int? waterId;
  final int? electricId;
  final double? total;
  final String? title;
  final double? owneing;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? rentPrice;
  final RoomEntity? room;

  const RoomBillEntity(
      {this.id,
      this.hostId,
      this.contractId,
      this.waterId,
      this.electricId,
      this.total,
      this.title,
      this.owneing,
      this.startDate,
      this.endDate,
      this.rentPrice,
      this.room})
      : super();

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        hostId,
        contractId,
        waterId,
        electricId,
        total,
        title,
        owneing,
        startDate,
        endDate,
        rentPrice,
        room,
      ];

  RoomBillEntity copyWith(
      {id,
      hostId,
      contractId,
      waterId,
      electricId,
      total,
      title,
      owneing,
      startDate,
      endDate,
      rentPrice,
      room,
      water,
      electric}) {
    return RoomBillEntity(
        id: id ?? this.id,
        hostId: hostId ?? this.hostId,
        contractId: contractId ?? this.contractId,
        waterId: water ?? this.waterId,
        electricId: electricId ?? this.electricId,
        total: total ?? this.total,
        title: title ?? this.title,
        owneing: owneing ?? this.owneing,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        rentPrice: rentPrice ?? this.rentPrice,
        room: room ?? this.room);
  }

  static List<RoomBillEntity> getGakeData() {
    var result = <RoomBillEntity>[];
    for (int i = 1; i <= 5; i++) {
      result.add(RoomBillEntity(
          id: i,
          hostId: 1,
          title: '${DateFormat('MMM y').format(DateTime.now().subtract(const Duration(days: 30)))} Bill',
          owneing: 0,
          contractId: i,
          rentPrice: 1000,
          waterId: i,
          electricId: i,
          startDate: DateTime.now().subtract(const Duration(days: 31)),
          endDate: DateTime.now()));
    }
    return result;
  }
}
