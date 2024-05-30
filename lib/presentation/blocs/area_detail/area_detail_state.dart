import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:dio/dio.dart';

abstract class AreaDetailState {
  final AreaEntity? area;
  final DioError? error;
  const AreaDetailState({this.area, this.error});
}

class AreaDetailLoadingState extends AreaDetailState{
  const AreaDetailLoadingState();
}

class AreaDetailDoneState extends AreaDetailState{
  const AreaDetailDoneState(AreaEntity area) : super(area: area);
}

class AreaDetailErrorState extends AreaDetailState{
  const AreaDetailErrorState(DioError error) : super(error: error);
}