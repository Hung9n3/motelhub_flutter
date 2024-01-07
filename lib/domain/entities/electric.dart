import 'dart:math';

import 'package:motelhub_flutter/domain/entities/bases/meter_reading.dart';

class ElectricEntity extends MeterReadingEntity {
  const ElectricEntity(
      {super.id,
      super.roomId,
      super.price,
      super.total,
      super.value,
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
          value: Random.secure().nextDouble() * 256,
          price: 2900,
          total: Random.secure().nextDouble() * 256 * 2900,
          createdAt: DateTime.now()));
    }
    return result;
  }
}
