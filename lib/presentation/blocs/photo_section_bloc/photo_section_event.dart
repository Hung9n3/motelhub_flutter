import 'package:image_picker/image_picker.dart';

abstract class PhotoSectionEvent {
  final ImageSource? mode;
  final int? selectedPhotoId;
  const PhotoSectionEvent({this.mode, this.selectedPhotoId});
}

class AddPhotoEvent extends PhotoSectionEvent {
  const AddPhotoEvent(ImageSource mode) : super(mode: mode);
}

class DeletePhotoEvent extends PhotoSectionEvent {
  const DeletePhotoEvent(int selectedPhotoId) : super(selectedPhotoId: selectedPhotoId);
}
