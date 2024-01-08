import 'package:flutter/cupertino.dart';
import 'package:motelhub_flutter/core/enums/option_sets.dart';
import 'package:motelhub_flutter/domain/entities/bases/meter_reading.dart';

class MeterReadingForm<T extends MeterReadingEntity> extends StatelessWidget {
  final int roomId;
  final int? meterReadingId;
  final MeterReadingType meterReadingType;
  const MeterReadingForm({super.key, required this.roomId, required this.meterReadingType, this.meterReadingId});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}