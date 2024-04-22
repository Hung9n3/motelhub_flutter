import 'package:equatable/equatable.dart';
import 'package:motelhub_flutter/core/resources/paging/paging_option.dart';
import 'package:motelhub_flutter/core/resources/search/search_range.dart';
import 'package:motelhub_flutter/core/resources/search/search_single.dart';
import 'package:motelhub_flutter/core/resources/search/search_text.dart';

class SearchModel extends Equatable {
  final PagingOption? pagingOption;
  final List<SearchSingle>? searchSingles;
  final List<SearchRange>? searchRanges;
  final List<SearchText>? searchText;

  const SearchModel(
      {this.pagingOption = const PagingOption(),
      this.searchSingles = const [],
      this.searchRanges = const [],
      this.searchText = const []});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
