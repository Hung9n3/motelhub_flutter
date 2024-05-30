import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/constants/constants.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/add_area/add_area_event.dart';
import 'package:motelhub_flutter/presentation/blocs/add_area/add_area_state.dart';

class AddAreaBloc extends Bloc<AddAreaEvent, AddAreaState> {
  final ITokenHandler _tokenHandler;
  final IAreaRepository _areaRepository;
  AddAreaBloc(this._tokenHandler, this._areaRepository)
      : super(AddAreaInitState()) {
    on<AddAreaInitEvent>(_loadingForm);
    on<ChangeAreaNameEvent>(_changeAreaName);
    on<ChangeAreaAddressEvent>(_changeAreaAddress);
    on<SubmitAreaEvent>(_submit);
  }

  _loadingForm(AddAreaInitEvent event, Emitter<AddAreaState> emit) async {
    emit(AddAreaLoadFormDoneState());
  }

  _changeAreaName(ChangeAreaNameEvent event, Emitter<AddAreaState> emit) async {
    state.name = event.name;
  }

  _changeAreaAddress(
      ChangeAreaAddressEvent event, Emitter<AddAreaState> emit) async {
    state.address = event.address;
  }

  _submit(SubmitAreaEvent event, Emitter<AddAreaState> emit) async {
    try {
      var userId = int.tryParse(await _tokenHandler.getByKey(currentUserIdKey));
      var area = AreaEntity(
          id: 0, address: state.address, name: state.name, hostId: userId);
      var result = await _areaRepository.save(area);
      if (result is DataSuccess) {
        emit(AddAreaSaveSuccess());
      } else {
        emit(AddAreaError());
      }
    } on Exception catch (e) {
      emit(AddAreaError());
    }
  }
}
