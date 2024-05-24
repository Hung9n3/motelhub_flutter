import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/repositories/bill_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/contract_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/bill_form/bill_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/bill_form/bill_form_state.dart';
import 'package:dio/dio.dart';

class BillFormBloc extends Bloc<BaseBillFormEvent, BaseBillFormState> {
  final IBillRepository _billRepository;
  final IContractRepository _contractRepository;
  final IRoomRepository _roomRepository;
  BillFormBloc(
      this._billRepository, this._contractRepository, this._roomRepository)
      : super(const BillFormLoading()) {
    on<BillFormInitEvent>(_getData);
    on<BillFormChangeDateEvent>(_changeDate);
    on<BillFormChangeTextEvent>(_changeText);
  }

  int? billId = 0;
  int? contractId = 0;
  String? roomName = '';
  double? oweing = 0;
  double? roomPrice = 0;
  double? electricPrice = 0;
  double? electricLast = 0;
  double? electricCurrent = 0;
  double? waterPrice = 0;
  double? waterLast = 0;
  double? waterCurrent = 0;
  DateTime? waterFrom;
  DateTime? waterTo;
  DateTime? electricFrom;
  DateTime? electricTo;

  _getData(BaseBillFormEvent event, Emitter<BaseBillFormState> emit) async {
    try {
      var contract = await _contractRepository.getById(event.contractId);
      var room = await _roomRepository.getById(contract.data!.roomId!);
      contractId = event.contractId;
      roomName = room.data?.name;
      roomPrice = room.data?.price;

      if (event.billId == null) {
        emit(const BillFormDone());
        return;
      }
      var dataState = await _billRepository.getById(billId);
      if (dataState is DataSuccess && dataState.data != null) {
        billId = billId;
        roomPrice = dataState.data!.rentPrice;
        waterPrice = dataState.data!.waterPrice;
        electricPrice = dataState.data!.electricPrice;
        oweing = dataState.data!.oweing;
        waterFrom = dataState.data!.waterFrom;
        waterTo = dataState.data!.waterTo;
        electricFrom = dataState.data!.electricFrom;
        electricTo = dataState.data!.electricTo;
        waterCurrent = dataState.data!.waterCurrent;
        waterLast = dataState.data!.waterLast;
        electricLast = dataState.data!.electricLast;
        electricCurrent = dataState.data!.electricCurrent;
      }
    } on DioError catch (e) {
      emit(BillFormError(e.message));
    } on Exception catch (ex) {
      emit(BillFormError(ex.toString()));
    }
  }

  _changeDate(BillFormChangeDateEvent event, Emitter<BaseBillFormState> emit) {
    try {
      electricFrom = event.electricFrom;
      electricTo = event.electricTo;
      waterFrom = event.waterFrom;
      waterTo = event.waterTo;
      emit(
          BillFormChangeDateDone(electricFrom, electricTo, waterFrom, waterTo));
    } on Exception catch (e) {
      emit(BillFormError(e.toString()));
    }
  }

  _changeText(BillFormChangeTextEvent event, Emitter<BaseBillFormState> emit) {
    try {
      roomPrice = double.tryParse(event.roomPrice ?? '0');
      electricPrice = double.tryParse(event.electricPrice ?? '0');
      electricLast = double.tryParse(event.electricLast ?? '0');
      electricCurrent = double.tryParse(event.electricCurrent ?? '0');
      waterPrice = double.tryParse(event.waterPrice ?? '0');
      waterLast = double.tryParse(event.waterLast ?? '0');
      waterCurrent = double.tryParse(event.waterCurrent ?? '0');

      var waterUsed = waterCurrent != null && waterLast != null ? waterCurrent! - waterLast! : 0.0;
      var waterTotal = waterPrice != null ? waterUsed * waterPrice! : 0.0;
      var electricUsed = electricCurrent != null && electricLast != null ? electricCurrent! - electricLast! : 0.0;
      var electricTotal = electricPrice != null ? electricUsed * electricPrice! : 0.0;
      var total = roomPrice ?? 0.0 + waterTotal + electricTotal;
      emit(BillFormChangeTextDone(total, electricUsed, waterUsed, electricTotal, waterTotal));
    } on Exception catch (e) {}
  }
}
