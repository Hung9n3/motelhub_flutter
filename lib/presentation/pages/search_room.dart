import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/search_room/search_room_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/search_room/search_room_event.dart';
import 'package:motelhub_flutter/presentation/blocs/search_room/search_room_state.dart';
import 'package:motelhub_flutter/presentation/components/commons/search_bar.dart';

class SearchRoom extends StatelessWidget {
  const SearchRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchRoomBloc>(
        create: (context) => sl()..add(const SearchRoomInitEvent()),
        child: BlocBuilder<SearchRoomBloc, SearchRoomState>(
          builder: (context, state) {
            return Scaffold(
              body: _buildBody(context),
            );
          },
        ));
  }

  _buildBody(BuildContext context) {
    var bloc = context.read<SearchRoomBloc>();
    return Column(
      children: [
        CustomSearchBar(
          bloc: bloc,
          event: const SearchRoomSubmitEvent(),
        )
      ],
    );
  }
}
