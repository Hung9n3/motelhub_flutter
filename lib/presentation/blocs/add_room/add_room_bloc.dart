import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/add_room/add_room_event.dart';
import 'package:motelhub_flutter/presentation/blocs/add_room/add_room_state.dart';

class AddRoomBloc extends Bloc<AddRoomEvent, AddRoomState> {
  final IAreaRepository _areaRepository;
  final IRoomRepository _roomRepository;
  final ITokenHandler _tokenHandler;
  AddRoomBloc(this._areaRepository, this._tokenHandler, this._roomRepository)
      : super(const LoadingFormState()) {
    on<LoadingFormEvent>(_loadingForm);
    on<ChangeRoomNameEvent>(_changeRoomName);
    on<ChangeAcreageEvent>(_changeAcreage);
    on<AddRoomOnSubmitButtonPressed>(_submit);
  }

  List<AreaEntity>? areas;
  String? roomName = '';
  double? acreage = 0.0;
  String? areaName = '';
  double? price = 0.0;

  _loadingForm(LoadingFormEvent event, Emitter<AddRoomState> emit) async {
    var area = await _areaRepository.getById(event.selectedAreaId ?? 0);
    if (area is DataSuccess) {
      areaName = area.data?.name ?? '';
    }
    emit(LoadingFormStateDone(areaName));
  }

  _changeRoomName(ChangeRoomNameEvent event, Emitter<AddRoomState> emit) async {
    roomName = event.textValue;
  }

  _changeAcreage(ChangeAcreageEvent event, Emitter<AddRoomState> emit) async {
    acreage = double.tryParse(event.textValue!);
  }

  _submit(
      AddRoomOnSubmitButtonPressed event, Emitter<AddRoomState> emit) async {
    try {
      var room = RoomEntity(
          id: 0,
          name: roomName,
          areaId: event.selectedAreaId,
          isEmpty: true,
          acreage: acreage,
          price: double.tryParse(event.price ?? '0.0') ?? 0.0,
          photos: event.photos ?? []
          );
      var result = await _roomRepository.save(room);
      if (result is DataSuccess) {
        emit(const AddRoomSuccess());
      } else {
        emit(AddRoomError(result.message));
      }
    } on Exception catch (e) {
      // TODO
      emit(AddRoomError(e.toString()));
    }
  }
}
