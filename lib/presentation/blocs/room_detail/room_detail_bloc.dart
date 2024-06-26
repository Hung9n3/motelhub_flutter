import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/constants/constants.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/entities/bill.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/domain/entities/contract.dart';
import 'package:motelhub_flutter/domain/entities/work_order.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/auth_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/contract_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/photo_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/work_order_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/base/base_state.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_event.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_state.dart';

class RoomDetailBloc extends Bloc<RoomDetailEvent, RoomDetailState> {
  final IRoomRepository _roomRepository;
  final IAreaRepository _areaRepository;
  final IPhotoRepository _photoRepository;
  final IAuthRepository _authRepository;
  final IContractRepository _contractRepository;
  final IWorkOrderRepository _workOrderRepository;
  final ITokenHandler _tokenHandler;

  RoomDetailBloc(this._roomRepository, this._tokenHandler, this._areaRepository,
      this._authRepository, this._contractRepository, this._workOrderRepository, this._photoRepository)
      : super(const RoomDetailLoadingFormState()) {
    on<LoadFormDataEvent>(_loadForm);
    on<SubmitFormEvent>(_submitForm);
    on<ChangeNameEvent>(_changeName);
    on<ChangeAcreageEvent>(_changeAcreage);
    on<ChangeOwnerEvent>(_changeOwner);
  }

  int? id;
  int? hostId;
  int? customerId;
  String? name;
  String? areaName;
  double? acreage;
  String? address = '';
  double? longitude = 0.0;
  double? latitude = 0.0;
  double? price = 0.0;
  int? areaId;
  bool isEmpty = false;
  List<UserEntity> users = [];
  List<PhotoEntity>? photos = [];
  List<ContractEntity>? contracts = [];
  List<WorkOrderEntity>? workOrders = [];
  int? role;
  bool isEditable = false;

  _loadForm(LoadFormDataEvent event, Emitter<RoomDetailState> emit) async {
    var dataState = await _roomRepository.getById(event.roomId!);
    if (dataState is DataSuccess) {
      var currentUserId =
          int.tryParse(await _tokenHandler.getByKey(currentUserIdKey));
      var room = dataState.data!;
      var area = (await _areaRepository.getById(room.areaId ?? 0)).data;
      if (area != null) {
        isEditable = currentUserId == area.hostId;
        longitude = area.longitude;
        latitude = area.latitude;
        address = area.address;
        areaName = area.name ?? '';
      }
      contracts = (await _contractRepository.getAll())
          .where((element) => element.roomId == room.id)
          .toList();
      workOrders = (await _workOrderRepository.getAll())
          .where((element) => element.roomId == room.id)
          .toList();
      if (currentUserId != area?.hostId) {
        contracts = contracts
                ?.where((element) => element.customerId == currentUserId)
                .toList() ??
            [];
        workOrders = workOrders
                ?.where((element) => element.customerId == currentUserId)
                .toList() ??
            [];
      }
      id = room.id;
      acreage = room.acreage ?? 0.0;
      areaId = room.areaId;
      isEmpty = room.isEmpty;
      photos = (await _photoRepository.getAll()).where((element) => element.roomId == id).toList();
      price = room.price ?? 0.0;
      name = room.name ?? '';
      customerId = room.customerId;

      users = await _authRepository.getAll();
      users.add(UserEntity(id: 0, name: 'None'));
      users.remove(users.where((element) => element.id == currentUserId).first);
      users.sort((a, b) => a.id!.compareTo(b.id!));
    
    emit(RoomDetailLoadFormStateDone(hostId, room.ownerName));
    } else {
      emit(const RoomDetailErrorState());
    }
  }

  _changeOwner(ChangeOwnerEvent event, Emitter<RoomDetailState> emit) async {
    var customer =
        users.where((element) => element.id == event.customer?.id).firstOrNull;
    customerId = customer?.id;
    emit(RoomDetailLoadFormStateDone(hostId, customer?.name));
  }

  _submitForm(SubmitFormEvent event, Emitter<RoomDetailState> emit) async {
    //Todo: implement submit logic
    try {
      var room = RoomEntity(
          id: id,
          name: name,
          acreage: acreage,
          photos: event.photos,
          customerId: customerId,
          price: double.tryParse(event.price ?? '') ?? 0.0,
          areaId: areaId);
      var result = await _roomRepository.save(room);
      if (result is DataSuccess) {
        emit(const SubmitFormSuccess());
      } else {
        emit(const RoomDetailErrorState());
      }
    } on Exception catch (err) {
      emit(const RoomDetailErrorState());
    }
  }

  _changeName(ChangeNameEvent event, Emitter<RoomDetailState> emit) async {
    name = event.name;
  }

  _changeAcreage(ChangeAcreageEvent event, Emitter<RoomDetailState> emit) async {
    if (event.acreage != null) {
      var doubleValue = double.tryParse(event.acreage!) ?? 0;
      acreage = doubleValue;
    }
  }
}
