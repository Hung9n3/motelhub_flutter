import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/core/resources/search/search_model.dart';
import 'package:motelhub_flutter/core/resources/search/search_range.dart';
import 'package:motelhub_flutter/core/resources/search/search_single.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/search_room/search_room_event.dart';
import 'package:motelhub_flutter/presentation/blocs/search_room/search_room_state.dart';

class SearchRoomBloc extends Bloc<SearchRoomEvent, SearchRoomState> {
  final IRoomRepository _roomRepository;

  SearchRoomBloc(this._roomRepository) : super(const SearchRoomLoadingState()) {
    on<SearchRoomEvent>(getRooms);
    on<SearchRoomCloseDialogEvent>(filterDialogClosed);
    on<SearchRoomSubmitEvent>(submit);
  }

  String roomName = '';
  String address = '';
  double priceFrom = 0;
  double priceTo = 0;
  double acreageFrom = 0;
  double acreageTo = 0;
  bool isAirConditioned = false;

  getRooms(SearchRoomEvent event, Emitter<SearchRoomState> emit) async {
    if (event is SearchRoomInitEvent || event is SearchRoomSubmitEvent) {
      var dataState =
          await this._roomRepository.Search(super.state.searchModel!);
      if (dataState is DataSuccess) {
        emit(SearchRoomDoneState(dataState.data ?? []));
      } else {
        emit(SearchRoomErrorState(dataState.message!));
      }
    }
  }

  submit(SearchRoomSubmitEvent event, Emitter<SearchRoomState> emit) async {
    roomName = event.roomName ?? '';
    address = event.address ?? '';
    priceFrom = validateNumber(double.tryParse(event.priceFrom ?? '') ?? 0);
    priceTo = validateNumber(double.tryParse(event.priceTo ?? '') ?? 0);
    acreageFrom = validateNumber(double.tryParse(event.acreageFrom ?? '') ?? 0);
    acreageTo = validateNumber(double.tryParse(event.acreageTo ?? '') ?? 0);
    isAirConditioned = event.isAirConditioned ?? false;
    List<SearchRange> searchRanges = [];
    if (priceFrom > 0 || priceTo > 0) {
      searchRanges
          .add(SearchRange(field: 'Price', from: priceFrom, to: priceTo));
    }
    if (acreageFrom > 0 && acreageTo > 0) {
      searchRanges
          .add(SearchRange(field: 'Acreage', from: acreageFrom, to: acreageTo));
    }
    List<SearchSingle> searchSingles = [];
    if (roomName != '') {
      searchSingles.add(SearchSingle(value: roomName, field: 'Name'));
    }
    if (address != '') {
      searchSingles.add(SearchSingle(value: address, field: 'Address'));
    }
    var searchModel = SearchModel(searchRanges: searchRanges, searchSingles: searchSingles);

    var dataState = await this._roomRepository.Search(searchModel);
    if (dataState is DataSuccess) {
      emit(SearchRoomDoneState(dataState.data ?? []));
    } else {
      emit(SearchRoomErrorState(dataState.message));
    }
  }

  filterDialogClosed(
      SearchRoomCloseDialogEvent event, Emitter<SearchRoomState> emit) {
    roomName = event.roomName ?? '';
    address = event.address ?? '';
    priceFrom = validateNumber(double.tryParse(event.priceFrom ?? '') ?? 0);
    priceTo = validateNumber(double.tryParse(event.priceTo ?? '') ?? 0);
    acreageFrom = validateNumber(double.tryParse(event.acreageFrom ?? '') ?? 0);
    acreageTo = validateNumber(double.tryParse(event.acreageTo ?? '') ?? 0);
    isAirConditioned = event.isAirConditioned ?? false;
    emit(SearchRoomDoneState(super.state.data ?? []));
  }

  double validateNumber(double number) {
    if (number < 0) {
      number = 0;
    }
    return number;
  }
}
