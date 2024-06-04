import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/data/api_service/api.dart';
import 'package:motelhub_flutter/domain/entities/contract.dart';
import 'package:motelhub_flutter/domain/entities/bill.dart';
import 'package:motelhub_flutter/domain/repositories/contract_repository_interface.dart';

class ContractRepository implements IContractRepository {
  @override
  Future<DataState<ContractEntity>> getById(int? contractId) async {
    // TODO: implement getById
    var contract = ContractEntity.getFakeData()
        .where((element) => element.id == contractId)
        .firstOrNull;
    var bills = BillEntity.getFakeData()
        .where((element) => element.contractId == contractId)
        .toList();
    var data = ContractEntity(
        id: contract?.id,
        roomId: contract?.roomId,
        customerId: contract?.customerId,
        bills: bills,
        startDate: contract?.startDate,
        endDate: contract?.endDate,
        cancelDate: contract?.cancelDate);
    return DataSuccess(data);
  }
  
  @override
  Future<List<ContractEntity>> getAll() async {
    try {
      var result = await Api.getContracts();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DataState> save(ContractEntity entity) async{
    var response = await Api.post(entity.toJson(), 'Contract');
    return Api.getResult(response);
  }
}
