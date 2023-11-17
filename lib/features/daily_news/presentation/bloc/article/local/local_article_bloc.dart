import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:motelhub_flutter/features/daily_news/presentation/bloc/article/local/local_article_state.dart';

import '../../../../domain/usecases/get_saved_article.dart';
import '../../../../domain/usecases/remove_article.dart';
import '../../../../domain/usecases/save_article.dart';

class LocalArticleBloc extends Bloc<LocalArticlesEvent,LocalArticlesState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticleBloc(
    this._getSavedArticleUseCase,
    this._saveArticleUseCase,
    this._removeArticleUseCase
  ) : super(const LocalArticlesLoading()){
    on <GetSavedArticlesEvent> (onGetSavedArticles);
    on <RemoveArticleEvent> (onRemoveArticle);
    on <SaveArticleEvent> (onSaveArticle);
  }


  void onGetSavedArticles(GetSavedArticlesEvent event,Emitter<LocalArticlesState> emit) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }
  
  void onRemoveArticle(RemoveArticleEvent removeArticleEvent,Emitter<LocalArticlesState> emit) async {
    await _removeArticleUseCase(params: removeArticleEvent.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  void onSaveArticle(SaveArticleEvent saveArticleEvent,Emitter<LocalArticlesState> emit) async {
    await _saveArticleUseCase(params: saveArticleEvent.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }
}