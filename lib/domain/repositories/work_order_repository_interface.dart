import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/work_order.dart';

abstract class IWorkOrderRepository {
  Future<DataState<WorkOrderEntity>> getById(int? workOrderId);
  Future<DataState<WorkOrderEntity>> save(WorkOrderEntity workOrderEntity);
}