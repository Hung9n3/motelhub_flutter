import 'dart:io';

import 'package:dio/dio.dart';
import 'package:motelhub_flutter/core/constants/constants.dart';
import 'package:motelhub_flutter/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:motelhub_flutter/features/daily_news/data/models/article.dart';
import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/features/daily_news/domain/entities/article.dart';
import 'package:motelhub_flutter/features/daily_news/domain/repositories/article_repository_interface';

import '../data_sources/remote/news_api_service.dart';

class ArticleRepositoryImpl implements IArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;
  ArticleRepositoryImpl(this._newsApiService,this._appDatabase);
  
  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
   try {
    final httpResponse = await _newsApiService.getNewsArticles(
      apiKey:newsAPIKey,
      country:countryQuery,
      category:categoryQuery,
    );

    if (httpResponse.response.statusCode == HttpStatus.ok) {
      return DataSuccess(httpResponse.data);
    } else {
      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioErrorType.response,
          requestOptions: httpResponse.response.requestOptions
        )
      );
    }
   } on DioError catch(e){
    return DataFailed(e);
   }
  }
  
  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    return _appDatabase.articleDAO.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.articleDAO.deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDAO.insertArticle(ArticleModel.fromEntity(article));
  }
  
}