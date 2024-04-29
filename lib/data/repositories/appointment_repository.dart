import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/domain/entities/appointment.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/repositories/appointment_repository_interface.dart';

class AppointmentRepository extends IAppointmentRepository{
  @override
  Future<DataState<List<AppointmentEntity>>> getByUser(int userId) async {
    // TODO: implement getByUser api
    var listData = AppointmentEntity.getFakeData();
    var data = listData.where((element) => element.creatorId == userId || element.participantId == userId).toList();
    return DataSuccess(data);
  }
  
  @override
  Future<DataState<AppointmentEntity>> getById(int id) async {
    // TODO: implement getById
    var listData = AppointmentEntity.getFakeData();
    var data = listData.where((element) => element.id == id).firstOrNull;
    return DataSuccess(data!);
  }

}