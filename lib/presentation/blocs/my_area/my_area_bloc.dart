import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/my_area/my_area_event.dart';
import 'package:motelhub_flutter/presentation/blocs/my_area/my_area_state.dart';

class MyAreaBloc extends Bloc<MyAreaEvent, MyAreaState>{

  final IAreaRepository _areaRepository;
  final IRoomRepository _roomRepository;
  final ITokenHandler _tokenHandler;

  MyAreaBloc(this._areaRepository, this._tokenHandler, this._roomRepository) : super(const MyAreaLoadingState()){
    on<GetMyAreaEvent>(getAreaList);
  }

  getAreaList(GetMyAreaEvent event, Emitter<MyAreaState> emit) async {
     final userId = int.tryParse(await _tokenHandler.getByKey('userId'));
     final dataState = await _areaRepository.getByHost(userId);
     final rooms = await _roomRepository.getAll();
     var rentings = rooms.where((element) => element.customerId == userId).toList();
    
    if(dataState is DataSuccess){
      //emit(MyAreaDoneState(dataState.data!, customerDataState.data!));
      emit(MyAreaDoneState(dataState.data ?? [], rentings));
    }
    if(dataState is DataFailed){
      emit(MyAreaError(dataState.message!));
    }
  }
}