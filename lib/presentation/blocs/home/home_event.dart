import 'package:equatable/equatable.dart';

enum NavigationTab {main, statistic, profile}

abstract class HomeEvent extends Equatable{
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class ChangeTabEvent extends HomeEvent{
  final NavigationTab tab;
  const ChangeTabEvent(this.tab);
}