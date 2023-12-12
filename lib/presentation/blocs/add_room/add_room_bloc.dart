import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:motelhub_flutter/features/daily_news/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/add_room/add_room_event.dart';
import 'package:motelhub_flutter/presentation/blocs/add_room/add_room_state.dart';

class AddRoomBloc extends Bloc<AddRoomEvent, AddRoomState> {
  final IAreaRepository _areaRepository;
  final ITokenHandler _tokenHandler;
  AddRoomBloc(this._areaRepository, this._tokenHandler)
      : super(const LoadingFormState()) {
    on<LoadingFormEvent>(_loadingForm);
    on<ChangeAreaEvent>(_changeArea);
    on<ChangeRoomNameEvent>(_changeRoomName);
    on<ChangeAcreageEvent>(_changeAcreage);
    on<AddRoomOnSubmitButtonPressed>(_submit);
  }

  List<AreaEntity>? areas;
  String? roomName;
  double? acreage;

  _loadingForm(LoadingFormEvent event, Emitter<AddRoomState> emit) async {
      var username = await _tokenHandler.getByKey('username');
      var areaDataState = await _areaRepository.getByUser(username);
      var areaList = List<AreaEntity>.empty();
      if (areaDataState is DataSuccess) {
        areaList = areaDataState.data!;
      }
      emit(LoadingFormStateDone(areaList, null, null));
  }

  _changeArea(ChangeAreaEvent event, Emitter<AddRoomState> emit) async {
    emit(LoadingFormStateDone(state.areas, event.selectedArea!.name, event.selectedArea!.id));
  }

  _changeRoomName(ChangeRoomNameEvent event, Emitter<AddRoomState> emit) async {
    roomName = event.textValue;
  }

  _changeAcreage(ChangeAcreageEvent event, Emitter<AddRoomState> emit) async {
    acreage = double.tryParse(event.textValue!);
  }

  _submit(AddRoomOnSubmitButtonPressed event, Emitter<AddRoomState> emit) async {
    var room = RoomEntity(id: 999, name: roomName, areaId: super.state.selectedAreaId, isEmpty: true, acreage: acreage);
    print(room);
  }
}
