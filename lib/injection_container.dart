import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:motelhub_flutter/core/token/token_handler.dart';
import 'package:motelhub_flutter/data/repositories/appointment_repository.dart';
import 'package:motelhub_flutter/data/repositories/auth_repository.dart';
import 'package:motelhub_flutter/data/repositories/area_repository.dart';
import 'package:motelhub_flutter/data/repositories/bill_repository.dart';
import 'package:motelhub_flutter/data/repositories/contract_repository.dart';
import 'package:motelhub_flutter/data/repositories/room_repository.dart';
import 'package:motelhub_flutter/data/repositories/work_order_repository.dart';
import 'package:motelhub_flutter/domain/repositories/appointment_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/auth_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/area_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/bill_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/contract_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/room_repository_interface.dart';
import 'package:motelhub_flutter/domain/repositories/work_order_repository_interface.dart';
import 'package:motelhub_flutter/domain/token/token_handler_interface.dart';
import 'package:motelhub_flutter/presentation/blocs/add_room/add_room_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/appointment_form/appointment_form_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/area_detail/area_detail_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/bill_form/bill_form_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/contract_form/contract_form_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/login/login_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/my_appointment/my_appointment_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/my_area/my_area_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/search_room/search_room_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/work_order_form/work_order_form_bloc.dart';

//import 'features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  //token
  sl.registerFactory<FlutterSecureStorage>(() => const FlutterSecureStorage());

  sl.registerFactory<ITokenHandler>(() => TokenHandler(sl()));

  //repository
  sl.registerFactory<IAuthRepository>(() => AuthRepository());
  sl.registerFactory<IAreaRepository>(() => AreaRepository());
  sl.registerFactory<IRoomRepository>(() => RoomRepository());
  sl.registerFactory<IAppointmentRepository>(() => AppointmentRepository());
  sl.registerFactory<IContractRepository>(() => ContractRepository());
  sl.registerFactory<IBillRepository>(() => BillRepository());
  sl.registerFactory<IWorkOrderRepository>(() => WorkOrderRepository());

  //Blocs
  sl.registerFactory<LoginBloc>(() => LoginBloc(sl(), sl()));
  sl.registerFactory<MyAreaBloc>(() => MyAreaBloc(sl(), sl()));
  sl.registerFactory<AreaDetailBloc>(() => AreaDetailBloc(sl(), sl(), sl()));
  sl.registerFactory<AddRoomBloc>(() => AddRoomBloc(sl(), sl()));
  sl.registerFactory<RoomDetailBloc>(() => RoomDetailBloc(sl(), sl()));
  sl.registerFactory<ContractFormBloc>(() => ContractFormBloc(sl(), sl()));
  sl.registerFactory<PhotoSectionBloc>(() => PhotoSectionBloc());
  sl.registerFactory<SearchRoomBloc>(() => SearchRoomBloc(sl()));
  sl.registerFactory<MyAppointmentBloc>(() => MyAppointmentBloc(sl(),sl()));
  sl.registerFactory<AppointmentFormBloc>(() => AppointmentFormBloc(sl(),sl()));
  sl.registerFactory<WorkOrderFormBloc>(() => WorkOrderFormBloc(sl()));
  sl.registerFactory<BillFormBloc>(() => BillFormBloc(sl(), sl(), sl()));
  // sl.registerFactory<LocalArticleBloc>(
  //   ()=> LocalArticleBloc(sl(),sl(),sl())
  // );
}
