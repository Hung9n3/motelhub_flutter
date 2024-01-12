import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/contract.dart';
import 'package:motelhub_flutter/domain/entities/electric.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/entities/room_bill.dart';
import 'package:motelhub_flutter/domain/entities/water.dart';
import 'package:motelhub_flutter/domain/repositories/contract_repository_interface.dart';

class ContractRepository implements IContractRepository {
  @override
  Future<DataState<ContractEntity>> getById(int? contractId) async {
    // TODO: implement getById
    var contract = ContractEntity.getFakeData()
        .where((element) => element.id == contractId)
        .firstOrNull;
    var bills = RoomBillEntity.getGakeData()
        .where((element) => element.contractId == contractId)
        .toList();
    var electrics = ElectricEntity.getFakeData();
    var waters = WaterEntity.getFakeData();
    for (var bill in bills) {
      var electric = electrics
          .where((electric) => electric.id == bill.electricId)
          .firstOrNull;
      var water =
          waters.where((water) => water.id == bill.electricId).firstOrNull;
      var total = electric!.total! + water!.total! + bill.rentPrice!;
      bill = bill.copyWith(total: total);
    }
    var data = ContractEntity(
        id: contract?.id,
        ownerId: contract?.ownerId,
        bills: bills,
        startDate: contract?.startDate,
        endDate: contract?.endDate,
        cancelDate: contract?.cancelDate);
    return DataSuccess(data);
  }
}
