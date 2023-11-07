import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:motelhub_flutter/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buidBody(),
    );
  }

  _buildAppbar(){
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(
          color: Colors.black
        ),),
    );
  }

  _buidBody(){
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
      builder: (context, state) {
        if(state is RemoteArticlesLoading){
          return const Center(child: CupertinoActivityIndicator());
        }
        if(state is RemoteArticlesError){
          return const Center(child: Icon(Icons.refresh),);
        }
        if(state is RemoteArticlesDone){
          return ListView.builder(
            itemBuilder: (context, index){
              return ListTile(
                title: Text('$index'),
              );
            }
          );
        }
        return const SizedBox();
      } );
  }
}