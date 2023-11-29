import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/enums/option_sets.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/login/login_bloc.dart';
import 'package:motelhub_flutter/presentation/pages/add_room.dart';
import 'package:motelhub_flutter/presentation/pages/area_detail_page.dart';
import 'package:motelhub_flutter/presentation/pages/home_page.dart';
import 'package:motelhub_flutter/presentation/pages/login_page.dart';

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
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
        routes: {
          '/home': (context) => const HomePage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/area-detail') {
            final args = settings.arguments as Map<String, dynamic>;
            final areaId = args['areaId'] as int;
            return MaterialPageRoute(
              builder: (context) => AreaDetailPage(areaId: areaId),
            );
          }
          if (settings.name == '/add-room') {
            final args = settings.arguments as Map<String, dynamic>;
            final mode = args['mode'] as FormMode;
            return MaterialPageRoute(
              builder: (context) => AddRoomPage(mode: mode),
            );
          }
        },
      ),
    );
  }
}
