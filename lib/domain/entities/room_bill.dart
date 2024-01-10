import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/electric.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/entities/water.dart';

class RoomBillEntity extends Equatable {
  final int? id;
  final int? hostId;
  final int? contractId;
  final int? waterId;
  final int? electricId;
  final double? total;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? rentPrice;
  final RoomEntity? room;
  final ElectricEntity? electric;
  final WaterEntity? water;

  const RoomBillEntity(
      {this.id,
      this.hostId,
      this.contractId,
      this.waterId,
      this.electricId,
      this.total,
      this.startDate,
      this.endDate,
      this.rentPrice,
      this.room,
      this.water,
      this.electric})
      : super();

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, contractId, waterId, electricId, total, startDate, endDate];

  static List<RoomBillEntity> getGakeData() {
    var result = <RoomBillEntity>[];
    for (int i = 1; i <= 5; i++) {
      result.add(RoomBillEntity(
          id: i,
          hostId: 1,
          contractId: i,
          waterId: i,
          electricId: i,
          total: 0,
          startDate: DateTime.now().subtract(const Duration(days: 31)),
          endDate: DateTime.now()));
    }
    return result;
  }
}
