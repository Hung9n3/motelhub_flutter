import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/home/home_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/home/home_event.dart';
import 'package:motelhub_flutter/presentation/components/my_area_component.dart';
import 'package:motelhub_flutter/presentation/components/profile_component.dart';
import 'package:motelhub_flutter/presentation/pages/my_appointment.dart';
import 'package:motelhub_flutter/presentation/pages/search_room.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
        create: (_) => HomeBloc(),
        child: BlocBuilder<HomeBloc, NavigationTab>(
          builder: (context, currentTab) {
            return Scaffold(
              body: _buildBody(currentTab),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentTab.index,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month_outlined),
                    label: 'Appointments',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
                onTap: (index) {
                  final tab = NavigationTab.values[index];
                  BlocProvider.of<HomeBloc>(context).add(ChangeTabEvent(tab));
                },
              ),
            );
          },
        ));
  }

  Widget _buildBody(NavigationTab currentTab) {
    switch (currentTab) {
      case NavigationTab.profile:
        return const ProfileComponent();
      case NavigationTab.search:
        return const SearchRoom();
      case NavigationTab.appointment:
        return const MyAppointment();
      default:
        return const MyAreaComponent();
    }
  }
}
