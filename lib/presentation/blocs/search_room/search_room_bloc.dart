import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/features/daily_news/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/search_room/search_room_event.dart';
import 'package:motelhub_flutter/presentation/blocs/search_room/search_room_state.dart';

class SearchRoomBloc extends Bloc<SearchRoomEvent, SearchRoomState> {
  final IRoomRepository _roomRepository;

  SearchRoomBloc(this._roomRepository) : super(const SearchRoomLoadingState()){
    on<SearchRoomEvent>(getRooms);
    on<SearchRoomSubmitEvent>(submit);
  }

  getRooms(SearchRoomEvent event, Emitter<SearchRoomState> emit) async {
    if(event is SearchRoomInitEvent || event is SearchRoomSubmitEvent) {
      var dataState = await this._roomRepository.Search(super.state.searchModel!);
      if(dataState is DataSuccess) {
        emit(SearchRoomDoneState(dataState.data ?? []));
      }
      else {
        emit(SearchRoomErrorState(dataState.error!));
      }
    }
  }

  submit(SearchRoomSubmitEvent event, Emitter<SearchRoomState> emit) async {
    var dataState = await this._roomRepository.Search(super.state.searchModel!);
    if(dataState is DataSuccess) {
        emit(SearchRoomDoneState(dataState.data ?? []));
      }
      else {
        emit(SearchRoomErrorState(dataState.error!));
      }
  }
}
