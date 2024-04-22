import 'package:motelhub_flutter/core/resources/search/search_model.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:dio/dio.dart';

abstract class SearchRoomState {
  final String? searchText;
  final SearchModel? searchModel;
  final List<RoomEntity>? data;
  final DioError? error;
  const SearchRoomState({this.searchModel = const SearchModel(), this.searchText, this.data, this.error});
}

class SearchRoomLoadingState extends SearchRoomState {
  const SearchRoomLoadingState();
}

class SearchRoomDoneState extends SearchRoomState{
  const SearchRoomDoneState(List<RoomEntity> data) : super(data: data);
}

class SearchRoomErrorState extends SearchRoomState {
  const SearchRoomErrorState(DioError error) : super(error: error);
}