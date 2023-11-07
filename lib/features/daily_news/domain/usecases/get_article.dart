import 'package:motelhub_flutter/core/resources/data_state.dart';
import 'package:motelhub_flutter/core/usecases/base_usecase.dart';
import 'package:motelhub_flutter/features/daily_news/domain/entities/article.dart';
import 'package:motelhub_flutter/features/daily_news/domain/repositories/article_repository_interface';

class GetArticleUseCase implements BaseUseCase<DataState<List<ArticleEntity>>,void>{
  
  final IArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);
  
  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getNewsArticles();
  }
  
}