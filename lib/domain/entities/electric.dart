import 'package:motelhub_flutter/domain/entities/bases/meter_reading.dart';

class ElectricEntity extends MeterReadingEntity {
  const ElectricEntity(
      {super.id,
      required super.roomId,
      required super.name,
      super.price,
      super.total,
      super.value,
      super.photos = const [],
      super.lastMonth,
      super.thisMonth,
      super.createdAt,
      super.isActive,
      super.modifiedAt})
      : super();

  static List<ElectricEntity> getFakeData() {
    List<ElectricEntity> result = [];
    for (int i = 1; i <= 50; i++) {
      result.add(ElectricEntity(
          id: i,
          roomId: i,
          name: 'December bill',
          lastMonth: 100,
          thisMonth: 200,
          value: 100,
          price: 2900,
          total: 100 * 2900,
          createdAt: DateTime.now()));
    }
    return result;
  }
}
