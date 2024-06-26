import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/bill.dart';
import 'package:motelhub_flutter/domain/entities/work_order.dart';

abstract class IBillRepository {
  List<BillEntity> getAll();
  Future<DataState<BillEntity>> getById(int? billId);
  Future<DataState<BillEntity>> save(BillEntity billEntity);
}