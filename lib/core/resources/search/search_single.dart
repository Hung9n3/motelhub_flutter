import 'package:equatable/equatable.dart';

class SearchSingle<T> extends Equatable {

  final T? value;
  final String? field;

  const SearchSingle({this.value, this.field});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
