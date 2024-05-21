import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';

class BillEntity extends Equatable {
  final int? id;
  final int? hostId;
  final int? contractId;
  final int? waterId;
  final int? electricId;
  final double? total;
  final String? title;
  final double? oweing;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? rentPrice;
  final double? waterPrice;
  final double? electricPrice;
  final double? electricLast;
  final double? electricCurrent;
  final double? waterLast;
  final double? waterCurrent;
  final DateTime? waterFrom;
  final DateTime? waterTo;
  final DateTime? electricFrom;
  final DateTime? electricTo;
  final RoomEntity? room;

  const BillEntity(
      {this.id,
      this.hostId,
      this.contractId,
      this.waterId,
      this.electricId,
      this.total,
      this.title,
      this.oweing,
      this.startDate,
      this.endDate,
      this.rentPrice,
      this.electricPrice,
      this.waterPrice,
      this.electricCurrent,
      this.electricFrom,
      this.electricLast,
      this.electricTo,
      this.waterCurrent,
      this.waterFrom,
      this.waterLast,
      this.waterTo,
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
        oweing,
        startDate,
        endDate,
        rentPrice,
        room,
      ];

  BillEntity copyWith(
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
    return BillEntity(
        id: id ?? this.id,
        hostId: hostId ?? this.hostId,
        contractId: contractId ?? this.contractId,
        waterId: water ?? this.waterId,
        electricId: electricId ?? this.electricId,
        total: total ?? this.total,
        title: title ?? this.title,
        oweing: owneing ?? this.oweing,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        rentPrice: rentPrice ?? this.rentPrice,
        room: room ?? this.room);
  }

  static List<BillEntity> getFakeData() {
    var result = <BillEntity>[];
    for (int i = 1; i <= 5; i++) {
      result.add(BillEntity(
          id: i,
          hostId: 1,
          title:
              '${DateFormat('MMM y').format(DateTime.now().subtract(const Duration(days: 30)))} Bill',
          oweing: 0,
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
