import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/constants/constants.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/entities/work_order.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/work_order_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/work_order_form/work_order_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/work_order_form/work_order_form_state.dart';

class WorkOrderFormBloc extends Bloc<WorkOrderFormEvent, WorkOrderFormState> {
  final IWorkOrderRepository _workOrderRepository;
  final IRoomRepository _roomRepository;
  final ITokenHandler _tokenHandler;
  WorkOrderFormBloc(this._workOrderRepository, this._tokenHandler, this._roomRepository)
      : super(const WorkOrderFormLoadingState()) {
    on<WorkOrderFormInitEvent>(getData);
    on<WorkOrderFormSubmitEvent>(submit);
    on<WorkOrderFormIsCustomerPayChangedEvent>(updateIsCustomerPay);
  }

  int workOrderId = 0;
  int roomId = 0;
  int contractId = 0;
  String name = '';
  String roomName = '';
  double price = 0;
  bool isCustomerPay = false;
  bool isOpen = true;
  List<PhotoEntity> photos = [];
  bool isEditable = false;
  bool isCreator = false;
  getData(
      WorkOrderFormInitEvent event, Emitter<WorkOrderFormState> emit) async {
    try {
      roomId = event.roomId!;
      var room = await _roomRepository.getById(roomId);
      roomName = room.data?.name ?? '';
      if (event.workOrderId == null || event.workOrderId == 0) {
        emit(const WorkOrderFormDoneState(false, true));
        return;
      }
      var dataState = await _workOrderRepository.getById(event.workOrderId);
      if (dataState is DataSuccess && dataState.data != null) {
        workOrderId = dataState.data!.id ?? 0;
        price = dataState.data!.price ?? 0;
        name = dataState.data!.name ?? '';
        isCustomerPay = dataState.data!.isCustomerPay ?? false;
        isOpen = dataState.data!.isOpen ?? false;
        photos = dataState.data!.photos ?? [];
        var currentUserId =
            int.tryParse(await _tokenHandler.getByKey(currentUserIdKey));
        if (currentUserId == dataState.data!.customerId) {
          isCreator = true;
        }
        emit(WorkOrderFormDoneState(isCustomerPay, isOpen));
      } else {
        emit(WorkOrderFormErrorState(dataState.message));
      }
    } on Error catch (e) {
      print(e);
    }
  }

  submit(
      WorkOrderFormSubmitEvent event, Emitter<WorkOrderFormState> emit) async {
    try {
      emit(const WorkOrderFormLoadingState());
      var workOrderEntity = WorkOrderEntity(
          id: workOrderId,
          roomId: roomId,
          customerId: int.tryParse(await _tokenHandler.getByKey(currentUserIdKey)),
          name: name,
          price: price,
          isCustomerPay: isCustomerPay,
          isOpen: isOpen,
          photos: photos);
      var dataState = await _workOrderRepository.save(workOrderEntity);
      if (dataState is DataSuccess) {
        emit(const WorkOrderSubmitDone());
      } else {
        emit(WorkOrderFormErrorState(dataState.message));
      }
    } on Error catch (e) {
      print(e);
    }
  }

  updateIsCustomerPay(WorkOrderFormIsCustomerPayChangedEvent event,
      Emitter<WorkOrderFormState> emit) {
    isCustomerPay = event.isCustomerPay ?? false;
    emit(WorkOrderFormDoneState(isCustomerPay, isOpen));
  }

  updateIsOpen(
      WorkOrderFormIsOpenChangedEvent event, Emitter<WorkOrderFormState> emit) {
    isOpen = event.isOpen ?? false;
    emit(WorkOrderFormDoneState(isCustomerPay, isOpen));
  }
}
