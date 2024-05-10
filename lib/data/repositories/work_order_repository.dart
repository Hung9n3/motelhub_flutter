import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/work_order.dart';
import 'package:motelhub_flutter/domain/repositories/work_order_repository_interface.dart';
import 'package:dio/dio.dart';

class WorkOrderRepository extends IWorkOrderRepository {
  @override
  Future<DataState<WorkOrderEntity>> getById(int? workOrderId) async {
    // TODO: implement getById
    try {
      var data = WorkOrderEntity.getFakeData().where((element) => element.id == workOrderId).firstOrNull;
      if(data != null) {
        return DataSuccess(data);
      }
      return const DataSuccess(null);
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<WorkOrderEntity>> save(WorkOrderEntity workOrderEntity) {
    // TODO: implement save
    throw UnimplementedError();
  }

}