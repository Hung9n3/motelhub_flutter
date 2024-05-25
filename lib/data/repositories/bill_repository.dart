import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/room_bill.dart';
import 'package:motelhub_flutter/domain/repositories/bill_repository_interface.dart';
import 'package:dio/dio.dart';

class BillRepository extends IBillRepository {
  @override
  Future<DataState<BillEntity>> getById(int? id) async {
    // TODO: implement getById
    try {
      var data = BillEntity.getFakeData().where((element) => element.id == id).firstOrNull;
      if(data != null) {
        return DataSuccess(data);
      }
      return const DataSuccess(null);
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<BillEntity>> save(BillEntity bill) async {
    // TODO: implement save
    return DataSuccess(bill);
  }

}