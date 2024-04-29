import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/enums/option_sets.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/login/login_bloc.dart';
import 'package:motelhub_flutter/presentation/pages/add_area.dart';
import 'package:motelhub_flutter/presentation/pages/add_room.dart';
import 'package:motelhub_flutter/presentation/pages/area_detail_page.dart';
import 'package:motelhub_flutter/presentation/pages/home_page.dart';
import 'package:motelhub_flutter/presentation/pages/login_page.dart';
import 'package:motelhub_flutter/presentation/pages/room_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => sl(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
        routes: {
          '/home': (context) => const HomePage(),
          '/add-area': (context) => const AddAreaPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/area-detail') {
            final args = settings.arguments as Map<String, dynamic>;
            final areaId = args['areaId'] as int;
            return MaterialPageRoute(
              builder: (context) => AreaDetailPage(areaId: areaId),
            );
          }
          if (settings.name == '/room-detail') {
            final args = settings.arguments as Map<String, dynamic>;
            final roomId = args['roomId'] as int;
            return MaterialPageRoute(
              builder: (context) => RoomDetailPage(roomId: roomId),
            );
          }
          if (settings.name == '/add-room') {
            final args = settings.arguments as Map<String, dynamic>;
            final mode = args['mode'] as FormMode;
            final selectedAreaId = args['selectedAreaId'] as int;
            return MaterialPageRoute(
              builder: (context) => AddRoomPage(mode: mode, selectedAreaId: selectedAreaId,),
            );
          }
          return null;
        },
      ),
    );
  }
}
