import 'package:equatable/equatable.dart';

class SearchRange<T> extends Equatable {

  final String? field;
  final T? from;
  final T? to;

  const SearchRange({this.field, this.from, this.to});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}