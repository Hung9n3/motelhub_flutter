import 'dart:typed_data';

import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/bill.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/domain/repositories/contract_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/contract_form/contract_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/contract_form/contract_form_state.dart';

class ContractFormBloc extends Bloc<ContractFormEvent, ContractFormState> {
  final IContractRepository _contractRepository;
  final ITokenHandler _tokenHandler;
  ContractFormBloc(this._contractRepository, this._tokenHandler)
      : super(const ContractFormLoading()) {
    on<ContractFormInitEvent>(_loadForm);
    on<SubmitContractFormEvent>(_submit);
    on<ContractFormChangeOwnerEvent>(_changeOwner);
    on<ContractFormChangeStartDateEvent>(_changeDate);
    on<ContractFormChangeEndDateEvent>(_changeDate);
    on<ContractFormChangeCancelDateEvent>(_changeDate);
  }

  List<BillEntity> bills = [];
  DateTime? startDate;
  DateTime? endDate;
  DateTime? cancelDate;
  double? priceRoom;
  int? customerId;
  int? isCustomerAccept;
  int? selectOwnerId;
  bool isOver = false;
  List<UserEntity> users = [];
  ByteData? signature;

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
        selectOwnerId = data.customerId;
        }
        var selectedOwner =
            users.where((element) => element.id == selectOwnerId).firstOrNull;
      selectOwnerId = 1;
        emit(ContractFormLoadDone(selectedOwner));
      } else {
        emit(const ContractFormNotFound());
      }
    }

  _changeOwner(ContractFormChangeOwnerEvent event, Emitter<ContractFormState> emit) {
    selectOwnerId = event.owner?.id;
  }

  _changeDate(ContractFormEvent event, Emitter<ContractFormState> emit) {
    if (event.selectedDate != null) {
      if (event is ContractFormChangeStartDateEvent) {
        startDate = event.selectedDate;
        if( startDate != null && endDate != null && startDate!.isAfter(endDate!)) {
          endDate = null;
          cancelDate = null;
        }
      }
      if (event is ContractFormChangeEndDateEvent) {
        endDate = event.selectedDate;
        if( cancelDate != null && endDate != null && endDate!.isAfter(cancelDate!)) {
          cancelDate = null;
        }
      }
      if (event is ContractFormChangeCancelDateEvent) {
        cancelDate = event.selectedDate;
      }
      emit(ContractFormChangeDateDone(state.selectedCustomer));
    }
  }

  _submit(SubmitContractFormEvent event, Emitter<ContractFormState> emit) {

  }
}
