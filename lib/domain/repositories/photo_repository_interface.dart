import 'package:flutter/foundation.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';

abstract class IPhotoRepository {
  Future<List<PhotoEntity>> getAll();
}