import 'package:motelhub_flutter/domain/entities/photo.dart';

abstract class IPhotoRepository {
  List<PhotoEntity> getAll();
}