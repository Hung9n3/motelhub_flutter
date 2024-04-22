import 'package:equatable/equatable.dart';

class PagingOption extends Equatable {

  final int? page;
  final int? size;
  final int? lastId;

  const PagingOption({this.page = 1, this.size = 20, this.lastId = 0});

  @override
  // TODO: implement props
  List<Object?> get props => [
    page, size, lastId
  ];

}