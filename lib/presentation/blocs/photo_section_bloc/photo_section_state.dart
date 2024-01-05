import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';

abstract class PhotoSectionState extends Equatable{
  final List<PhotoEntity>? photos;
  final Exception? error;
  const PhotoSectionState({this.photos, this.error}) : super();

  List<Object?> get props => [photos, error];
}

class InitState extends PhotoSectionState{
  const InitState(List<PhotoEntity> photos) : super(photos: photos);
}

class GetPhotoSuccess extends PhotoSectionState {
  const GetPhotoSuccess(List<PhotoEntity> photos) : super(photos: photos);
}

class GetPhotoFailed extends PhotoSectionState{
  const GetPhotoFailed(Exception exception, List<PhotoEntity> currentPhotos) : super(error: exception, photos: currentPhotos);
}

class DeletePhotoSuccess extends PhotoSectionState {
  const DeletePhotoSuccess(List<PhotoEntity> remainPhotos) : super(photos: remainPhotos);
}