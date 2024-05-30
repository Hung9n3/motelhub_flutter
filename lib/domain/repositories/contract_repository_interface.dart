import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/contract.dart';

abstract class IContractRepository {
  Future<DataState<ContractEntity>> getById(int? contractId);
  Future<List<ContractEntity>> getAll();
}