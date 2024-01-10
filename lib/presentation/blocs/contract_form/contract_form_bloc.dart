import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/room_bill.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/domain/repositories/contract_repository_interface.dart';
import 'package:motelhub_flutter/features/daily_news/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/contract_form/contract_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/contract_form/contract_form_state.dart';

class ContractFormBloc extends Bloc<ContractFormEvent, ContractFormState> {
  final IContractRepository _contractRepository;
  final ITokenHandler _tokenHandler;
  ContractFormBloc(this._contractRepository, this._tokenHandler)
      : super(const ContractFormLoading()) {
        on<ContractFormInitEvent>(_loadForm);
        on<SubmitContractFormEvent>(_submit);
      }

  List<RoomBillEntity> bills = [];
  DateTime? startDate;
  DateTime? endDate;
  DateTime? cancelDate;
  int? selectOwnerId;
  List<UserEntity> users = [];

  _loadForm(ContractFormEvent event, Emitter<ContractFormState> emit) async {
    users = UserEntity.getFakeData() ?? users;
    if (event.contractId == null) {
      emit(ContractFormLoadDone(null));
    }
    var dataState = await _contractRepository.getById(event.contractId);
    if (dataState is DataSuccess) {
      var data = dataState.data;
      if (data != null) {
        bills = data.bills ?? bills;
        startDate = data.startDate;
        endDate = data.endDate;
        cancelDate = data.cancelDate;
        selectOwnerId = data.ownerId;
        var selectedOwner =
            users.where((element) => element.id == selectOwnerId).firstOrNull;
        emit(ContractFormLoadDone(selectedOwner));
      } else {
        emit(const ContractFormNotFound());
      }
    }
  }

  _submit(SubmitContractFormEvent event, Emitter<ContractFormState> emit){

  }
}
