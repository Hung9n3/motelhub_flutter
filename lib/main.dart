import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/config/themes/app_themes.dart';
import 'package:motelhub_flutter/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:motelhub_flutter/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:motelhub_flutter/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/login/login_bloc.dart';
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
      create: (context) => LoginBloc(),
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      home: const LoginPage()),
    );
  }
}
