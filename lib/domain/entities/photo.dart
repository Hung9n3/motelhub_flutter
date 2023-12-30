import 'dart:io';

import 'package:equatable/equatable.dart';

class PhotoEntity extends Equatable{
  final int? id;
  final String? name;
  final int? roomId;
  final int? areaId;
  final int? userId;
  final String? url;
  final File? data;

  const PhotoEntity({this.id, this.name, this.data, this.url, this.areaId, this.roomId, this.userId});
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, data, url];
}