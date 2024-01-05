import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/features/daily_news/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/base/base_state.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_event.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_state.dart';

class RoomDetailBloc extends Bloc<RoomDetailEvent, RoomDetailState> {
  final IRoomRepository _roomRepository;
  final ITokenHandler _tokenHandler;

  RoomDetailBloc(this._roomRepository, this._tokenHandler)
      : super(const RoomDetailLoadingFormState()) {
    on<LoadFormDataEvent>(_loadForm);
    on<SubmitFormEvent>(_submitForm);
    on<ChangeNameEvent>(_changeName);
    on<ChangeAcreageEvent>(_changeAcreage);
  }

  int? id;
  String? name;
  String? areaName;
  double? acreage;
  int? areaId;
  bool isEmpty = false;
  List<PhotoEntity>? photos;
  int? role;

  _loadForm(LoadFormDataEvent event, Emitter<BaseState> emit) async {
    var dataState = await _roomRepository.getById(event.roomId!);
    if (dataState is DataSuccess && dataState.data != null) {
      var room = dataState.data!;
      id = room.id;
      acreage = room.acreage;
      areaId = room.areaId;
      isEmpty = room.isEmpty;
      //photos = room.photos;
      name = room.name;
      areaName = room.areaName;

      photos = [
        const PhotoEntity(id: 1, url: 'https://picsum.photos/250?image=9'),
      ];

      emit(const RoomDetailLoadFormStateDone());
    } else {
      emit(ErrorState(dataState.error));
    }
  }

  _submitForm(SubmitFormEvent event, Emitter<BaseState> emit) async {
    //Todo: implement submit logic
    try {
      var room = RoomEntity(
          id: id,
          name: name,
          acreage: acreage,
          photos: event.photos,
          isEmpty: isEmpty,
          areaId: areaId);
      emit(const SubmitFormSuccess());
      print(room);
    } on Exception catch (err) {
      emit(ErrorState(err));
    }
  }

  _changeName(ChangeNameEvent event, Emitter<BaseState> emit) async {
    name = event.name;
  }

  _changeAcreage(ChangeAcreageEvent event, Emitter<BaseState> emit) async {
    if (event.acreage != null) {
      var doubleValue = double.tryParse(event.acreage!) ?? 0;
      acreage = doubleValue;
    }
  }
}
