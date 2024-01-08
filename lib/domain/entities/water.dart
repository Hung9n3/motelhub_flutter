import 'dart:math';

import 'package:motelhub_flutter/domain/entities/bases/meter_reading.dart';

class WaterEntity extends MeterReadingEntity {
  const WaterEntity(
      {super.id,
      required super.roomId,
      required super.name,
      super.price,
      super.total,
      super.value,
      super.lastMonth,
      super.thisMonth,
      super.photos = const [],
      super.createdAt,
      super.isActive,
      super.modifiedAt})
      : super();

  static List<WaterEntity> getFakeData() {
    List<WaterEntity> result = [];
    for (int i = 1; i <= 50; i++) {
      result.add(WaterEntity(
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
