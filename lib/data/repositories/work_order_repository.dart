import 'package:flutter/widgets.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/data/api_service/api.dart';
import 'package:motelhub_flutter/domain/entities/work_order.dart';
import 'package:motelhub_flutter/domain/repositories/work_order_repository_interface.dart';
import 'package:dio/dio.dart';

class WorkOrderRepository extends IWorkOrderRepository {
  @override
  Future<DataState<WorkOrderEntity>> getById(int? workOrderId) async {
    try {
      var workOrders = await Api.getWorkOrders();
      var result = workOrders.where((element) => element.id == workOrderId).firstOrNull;
      return DataSuccess(result); 
    } on Exception catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState> save(WorkOrderEntity workOrderEntity) async {
    var response = await Api.post(workOrderEntity.toJson(), 'WorkOrder');
    var result = Api.getResult(response);
    return result;
  }
  
  @override
  Future<List<WorkOrderEntity>> getAll() async {
    var result = await Api.getWorkOrders();
    return result;
  }

}