import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import '../../../../domain/entities/article.dart';

abstract class LocalArticlesState extends Equatable {
  final List<ArticleEntity> ? articles;
  final DioError ? error;
  
  const LocalArticlesState({this.articles,this.error});
  
  @override
  List<Object> get props => [articles!, error!];
}

class LocalArticlesLoading extends LocalArticlesState {
  const LocalArticlesLoading();
}

class LocalArticlesDone extends LocalArticlesState {
  const LocalArticlesDone(List<ArticleEntity> article) : super(articles: article);
}

class LocalArticlesError extends LocalArticlesState {
  const LocalArticlesError(DioError error) : super(error: error);
}