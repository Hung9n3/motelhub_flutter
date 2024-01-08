import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/enums/option_sets.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/bases/meter_reading.dart';
import 'package:motelhub_flutter/domain/entities/electric.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/entities/water.dart';
import 'package:motelhub_flutter/domain/repositories/meter_reading_repository_interface.dart';
import 'package:motelhub_flutter/features/daily_news/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/base/base_state.dart';
import 'package:motelhub_flutter/presentation/blocs/meter_reading_form/meter_reading_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/meter_reading_form/meter_reading_form_state.dart';

class MeterReadingFormBloc
    extends Bloc<MeterReadingFormEvent, MeterReadingFormState> {
  final IMeterReadingRepository _meterReadingRepository;
  final ITokenHandler _tokenHandler;

  MeterReadingFormBloc(this._meterReadingRepository, this._tokenHandler)
      : super(const MeterReadingFormLoading()) {
    on<InitFormEvent>(_loadForm);
  }

  List<PhotoEntity>? photos;
  int? id;
  String? name = '';
  double? thisMonth = 0;
  double? lastMonth = 0;
  double? value = 0;
  double? price = 0;
  double? total = 0;

  _loadForm(InitFormEvent event, Emitter<BaseState> emit) async {
    if (event.meterReadingId == null) {
      name = 'Month ${DateTime.now().month}';
      emit(const MeterReadingFormLoadDone());
    } else {
      var dataState = await _meterReadingRepository.getById(
          event.meterReadingId, event.type);
      if (dataState is DataSuccess) {
        var data = dataState.data;
        if (data != null) {
          name = data.name;
          thisMonth = data.thisMonth;
          lastMonth = data.lastMonth;
          value = data.value;
          price = data.price;
          total = data.total;
          photos = data.photos;

          emit(const MeterReadingFormLoadDone());
        } else {
          emit(const MeterReadingFormNotFound());
        }
      }
    }
  }

  _changeName(ChangeNameEvent event, Emitter<BaseState> emit) async {
    name = event.textValue;
  }

  _changeLastMonth(ChangeLastMonthEvent event, Emitter<BaseState> emit) async {
    lastMonth = double.parse(event.textValue!);
    value = lastMonth! - thisMonth!;
    total = value! * price!;
  }

  _changeThisMonth(ChangeThisMonthEvent event, Emitter<BaseState> emit) async {
    thisMonth = double.parse(event.textValue!);
    value = lastMonth! - thisMonth!;
    total = value! * price!;
  }

  _changePrice(ChangePriceEvent event, Emitter<BaseState> emit) async {
    price = double.parse(event.textValue!);
    total = value! * price!;
  }

  _submit(SubmitFormEvent event, Emitter<BaseState> emit) async {
    late MeterReadingEntity entity;
    switch (event.type) {
      case MeterReadingType.water:
        entity = WaterEntity(
            id: id,
            roomId: event.meterReadingId,
            name: name,
            thisMonth: thisMonth,
            lastMonth: lastMonth,
            price: price,
            value: value,
            total: total,
            photos: photos);
        break;
      default:
        entity = ElectricEntity(
            id: id,
            roomId: event.meterReadingId,
            name: name,
            thisMonth: thisMonth,
            lastMonth: lastMonth,
            price: price,
            value: value,
            total: total,
            photos: photos);
        break;
    }
    //todo: put implement api code here
    var dataState = await _meterReadingRepository.submit(entity, event.type);
    if (dataState is DataSuccess) {
      emit(const SubmitFormSuccess());
    } else {
      emit(ErrorState(dataState.error!));
    }
  }
}
