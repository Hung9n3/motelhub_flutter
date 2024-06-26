import 'dart:convert';

import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/data/api_service/api.dart';
import 'package:motelhub_flutter/domain/entities/contract.dart';
import 'package:motelhub_flutter/domain/entities/bill.dart';
import 'package:motelhub_flutter/domain/repositories/contract_repository_interface.dart';

class ContractRepository implements IContractRepository {
  @override
  Future<DataState<ContractEntity>> getById(int? contractId) async {
    // TODO: implement getById
    var data = await Api.getContracts();
    return DataSuccess(data.where((element) => element.id == contractId).firstOrNull);
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
    try {
      
      var response = await Api.post(jsonEncode(entity.toJson()), 'Contract');
      var result = Api.getResult(response);
      if(result is DataSuccess) {
        var data = ContractEntity.contracts;
        if(entity.id == 0 || entity.id == null) {
          entity.id = result.data!;
          data.add(entity);
        }else {
          var exist = data.where((element) => element.id == entity.id).firstOrNull;
          if(exist != null) {
            data.remove(exist);
          }
          data.add(entity);
        }
      }
      return result;
    } catch (e) {
      throw e;
    }
  }
}
