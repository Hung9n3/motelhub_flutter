import 'package:motelhub_flutter/data/api_service/api.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/domain/repositories/photo_repository_interface.dart';

class PhotoRepository extends IPhotoRepository {
  @override
  Future<List<PhotoEntity>> getAll() async {
    //var data = await Api.getPhotos();
    var data = PhotoEntity.photos;
    return data;
  }

}