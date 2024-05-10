import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:motelhub_flutter/core/token/token_handler.dart';
import 'package:motelhub_flutter/data/repositories/appointment_repository.dart';
import 'package:motelhub_flutter/data/repositories/auth_repository.dart';
import 'package:motelhub_flutter/data/repositories/area_repository.dart';
import 'package:motelhub_flutter/data/repositories/contract_repository.dart';
import 'package:motelhub_flutter/data/repositories/room_repository.dart';
import 'package:motelhub_flutter/data/repositories/work_order_repository.dart';
import 'package:motelhub_flutter/domain/entities/area.dart';
import 'package:motelhub_flutter/domain/repositories/appointment_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/auth_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/contract_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/work_order_repository_interface.dart';
import 'package:motelhub_flutter/domain/usecases/area_detail/get_area_detail_usecases.dart';
import 'package:motelhub_flutter/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:motelhub_flutter/features/daily_news/data/repositories/article_repository.dart';
import 'package:motelhub_flutter/features/daily_news/domain/repositories/article_repository_interface';
import 'package:motelhub_flutter/features/daily_news/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/features/daily_news/domain/usecases/get_article.dart';
import 'package:motelhub_flutter/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/add_room/add_room_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/area_detail/area_detail_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/contract_form/contract_form_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/login/login_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/my_appointment/my_appointment_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/my_area/my_area_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/search_room/search_room_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/work_order_form/work_order_form_bloc.dart';
import 'features/daily_news/data/data_sources/local/app_database.dart';
import 'features/daily_news/domain/usecases/get_saved_article.dart';
import 'features/daily_news/domain/usecases/remove_article.dart';
import 'features/daily_news/domain/usecases/save_article.dart';
//import 'features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  //token
  sl.registerFactory<FlutterSecureStorage>(() => const FlutterSecureStorage());

  sl.registerFactory<ITokenHandler>(() => TokenHandler(sl()));

  //repository
  sl.registerSingleton<IArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

  sl.registerFactory<IAuthRepository>(() => AuthRepository());
  sl.registerFactory<IAreaRepository>(() => AreaRepository());
  sl.registerFactory<IRoomRepository>(() => RoomRepository());
  sl.registerFactory<IAppointmentRepository>(() => AppointmentRepository());
  sl.registerFactory<IContractRepository>(() => ContractRepository());
  sl.registerFactory<IWorkOrderRepository>(() => WorkOrderRepository());

  //UseCases
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));

  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));

  sl.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(sl()));

  sl.registerFactory<GetAreaDetailUseCase>(
      () => GetAreaDetailUseCase(sl(), sl()));

  //Blocs
  sl.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(sl()));
  sl.registerFactory<LoginBloc>(() => LoginBloc(sl(), sl()));
  sl.registerFactory<MyAreaBloc>(() => MyAreaBloc(sl(), sl()));
  sl.registerFactory<AreaDetailBloc>(() => AreaDetailBloc(sl()));
  sl.registerFactory<AddRoomBloc>(() => AddRoomBloc(sl(), sl()));
  sl.registerFactory<RoomDetailBloc>(() => RoomDetailBloc(sl(), sl()));
  sl.registerFactory<ContractFormBloc>(() => ContractFormBloc(sl(), sl()));
  sl.registerFactory<PhotoSectionBloc>(() => PhotoSectionBloc());
  sl.registerFactory<SearchRoomBloc>(() => SearchRoomBloc(sl()));
  sl.registerFactory<MyAppointmentBloc>(() => MyAppointmentBloc(sl(),sl()));
  sl.registerFactory<WorkOrderFormBloc>(() => WorkOrderFormBloc(sl()));
  // sl.registerFactory<LocalArticleBloc>(
  //   ()=> LocalArticleBloc(sl(),sl(),sl())
  // );
}
