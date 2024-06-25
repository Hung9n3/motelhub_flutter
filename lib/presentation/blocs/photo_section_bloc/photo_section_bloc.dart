import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motelhub_flutter/domain/entities/photo.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_event.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_state.dart';

class PhotoSectionBloc extends Bloc<PhotoSectionEvent, PhotoSectionState> {
  PhotoSectionBloc() : super(const InitState([])) {
    on<AddPhotoEvent>(_onAddPhoto);
    on<UpdatePhotosEvent>(_initPhoto);
  }

  _initPhoto(UpdatePhotosEvent event, Emitter<PhotoSectionState> emit) async {
    try {
      if (event.photos == null) {
        emit(const InitState([]));
        return;
      }
      for (var photo in event.photos!) {
        if (photo.photoData != null) {
          photo.file = await File("photo_${photo.id}")
              .writeAsBytes(base64Decode(photo.photoData!));
        }
      }
      emit(InitState(event.photos!));
    } catch (err) {
      print(err);
    }
  }

  _onAddPhoto(AddPhotoEvent event, Emitter<PhotoSectionState> emit) async {
    try {
      var photo = await ImagePicker().pickImage(source: event.mode!);
      if (photo == null) {
        return;
      } else {
        var file = File(photo.path);
        var photoData = base64Encode(await file.readAsBytes());
        var entity = PhotoEntity(
            id: 0, name: null, file: file, url: null, photoData: photoData);
        if (state.photos != null) {
          var currentPhotos = state.photos!.toList();
          currentPhotos.add(entity);
          emit(GetPhotoSuccess(currentPhotos));
        }
      }
    } on Exception catch (ex) {
      emit(GetPhotoFailed(ex, state.photos!));
    }
  }

  _onDeletePhoto(
      DeletePhotoEvent event, Emitter<PhotoSectionState> emit) async {
    var currentPhotos = state.photos!;
    currentPhotos.removeWhere((element) => element.id == event.selectedPhotoId);
    emit(DeletePhotoSuccess(currentPhotos));
  }
}
