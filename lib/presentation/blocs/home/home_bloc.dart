import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/home/home_event.dart';

class HomeBloc extends Bloc<HomeEvent, NavigationTab>{
  HomeBloc() : super(NavigationTab.main){
    on<ChangeTabEvent>(changeTab);
  }

  void changeTab(HomeEvent event, Emitter<NavigationTab> emit){
    if(event is ChangeTabEvent){
      emit(event.tab);
    }
  }
}