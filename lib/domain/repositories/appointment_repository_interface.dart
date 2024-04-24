import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/appointment.dart';

abstract class IAppointmentRepository {
  Future<DataState<List<AppointmentEntity>>> getByUser(int userId);
  Future<DataState<AppointmentEntity>> getById(int id);
}