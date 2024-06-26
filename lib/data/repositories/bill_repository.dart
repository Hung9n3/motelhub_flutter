import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/bill.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/repositories/bill_repository_interface.dart';
import 'package:dio/dio.dart';

class BillRepository extends IBillRepository {
  @override
  Future<DataState<BillEntity>> getById(int? id) async {
    // TODO: implement getById
    try {
      var data = BillEntity.bills.where((element) => element.id == id).firstOrNull;
      if(data != null) {
        return DataSuccess(data);
      }
      return const DataSuccess(null);
    } on DioError catch (e) {
      return DataFailed(e.message);
    }
  }

  @override
  Future<DataState<BillEntity>> save(BillEntity bill) async {
    var data = BillEntity.bills;
    data.sort(((a, b) => a.id!.compareTo(b.id!)));
    var lastId = data.lastOrNull?.id;
    if(bill.id == 0 || bill.id == null){
    bill.id = lastId ?? 0 + 1;
    data.add(bill);
    }
    else {
      var entity = data.where((element) => element.id == bill.id).firstOrNull;
      if(entity != null) {
        data.remove(entity);
        data.add(bill);
      }
    }
    for(var photo in bill.photos ?? []) {
      if(photo.roomId !=null || photo.roomId != 0) {
        continue;
      }
      photo.billId = bill.id;
      PhotoEntity.photos.add(photo);
    }
    return DataSuccess(bill);
  }
  
  @override
  List<BillEntity> getAll() {
    return BillEntity.bills;
  }

}