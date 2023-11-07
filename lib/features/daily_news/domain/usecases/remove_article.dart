import 'package:motelhub_flutter/core/usecases/base_usecase.dart';
import 'package:motelhub_flutter/features/daily_news/domain/entities/article.dart';
import 'package:motelhub_flutter/features/daily_news/domain/repositories/article_repository_interface';

class RemoveArticleUseCase implements BaseUseCase<void,ArticleEntity>{
  
  final IArticleRepository _articleRepository;

  RemoveArticleUseCase(this._articleRepository);
  
  @override
  Future<void> call({ArticleEntity ? params}) {
    return _articleRepository.removeArticle(params!);
  }
  
}