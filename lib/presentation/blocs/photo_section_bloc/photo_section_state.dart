import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';

abstract class PhotoSectionState {
  List<PhotoEntity>? photos;
  final Exception? error;
  PhotoSectionState({this.photos, this.error}) : super();

  List<Object?> get props => [photos, error];
}

class InitState extends PhotoSectionState{
  InitState(List<PhotoEntity> photos) : super(photos: photos);
}

class GetPhotoSuccess extends PhotoSectionState {
  GetPhotoSuccess(List<PhotoEntity> photos) : super(photos: photos);
}

class GetPhotoFailed extends PhotoSectionState{
  GetPhotoFailed(Exception exception) : super(error: exception);
}