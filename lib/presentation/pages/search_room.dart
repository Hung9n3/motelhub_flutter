import 'package:flutter/cupertino.dart';
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
            if (state is SearchRoomErrorState) {
              return Center(
                child: Text("${state.error}"),
              );
            }
            if (state is SearchRoomLoadingState) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is SearchRoomDoneState) {
              return _buildBody(context);
            }
            return const SizedBox();
          },
        ));
  }

  _buildBody(BuildContext context) {
    var bloc = context.read<SearchRoomBloc>();
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          CustomSearchBar(
            bloc: bloc,
            event: const SearchRoomSubmitEvent(),
            filterDialog: _buildDialog(context),
          )
        ],
      ),
    ));
  }

  Widget _buildDialog(BuildContext context) {
    var bloc = context.read<SearchRoomBloc>();
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      content: const Column(children: [
        ListTile(
          leading: Text('Address'),
          title: TextField(),
        )
      ]),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close')),
        TextButton(
            onPressed: () {
              bloc.add(const SearchRoomSubmitEvent());
              Navigator.of(context).pop();
            },
            child: const Text('Submit'))
      ],
    );
  }
}
