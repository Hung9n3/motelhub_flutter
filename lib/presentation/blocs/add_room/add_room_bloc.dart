import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
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
    var areaName = state.areas!.where((element) => element.id == event.selectedAreaId).firstOrNull?.name;
    emit(LoadingFormStateDone(state.areas, areaName, event.selectedAreaId));
  }

  _changeRoomName(ChangeRoomNameEvent event, Emitter<AddRoomState> emit) async {
    roomName = event.textValue;
  }

  _changeAcreage(ChangeAcreageEvent event, Emitter<AddRoomState> emit) async {
    acreage = double.tryParse(event.textValue!);
  }
}
