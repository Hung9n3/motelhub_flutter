import 'package:image_picker/image_picker.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';

abstract class PhotoSectionEvent {
  final ImageSource? mode;
  final int? selectedPhotoId;
  final List<PhotoEntity>? photos;

  const PhotoSectionEvent({this.mode, this.selectedPhotoId, this.photos});
}

class UpdatePhotosEvent extends PhotoSectionEvent {
  const UpdatePhotosEvent(List<PhotoEntity> photos) : super(photos: photos);
}

class AddPhotoEvent extends PhotoSectionEvent {
  const AddPhotoEvent(ImageSource mode) : super(mode: mode);
}

class DeletePhotoEvent extends PhotoSectionEvent {
  const DeletePhotoEvent(int selectedPhotoId) : super(selectedPhotoId: selectedPhotoId);
}
