import 'package:motelhub_flutter/core/usecases/base_usecase.dart';
import 'package:motelhub_flutter/features/daily_news/domain/entities/article.dart';
import 'package:motelhub_flutter/features/daily_news/domain/repositories/article_repository_interface';

class GetSavedArticleUseCase implements BaseUseCase<List<ArticleEntity>,void>{
  
  final IArticleRepository _articleRepository;

  GetSavedArticleUseCase(this._articleRepository);
  
  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepository.getSavedArticles();
  }
  
}