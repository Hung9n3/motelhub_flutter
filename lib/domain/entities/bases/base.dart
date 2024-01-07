import 'package:equatable/equatable.dart';

abstract class BaseEntity extends Equatable{
  final DateTime? createdAt;
  final DateTime? modifiedAt;
  final bool? isActive;

  const BaseEntity({this.createdAt, this.modifiedAt, this.isActive = true});
}