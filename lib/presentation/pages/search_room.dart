import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/core/enums/option_sets.dart';
import 'package:motelhub_flutter/domain/entities/room.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/search_room/search_room_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/search_room/search_room_event.dart';
import 'package:motelhub_flutter/presentation/blocs/search_room/search_room_state.dart';
import 'package:motelhub_flutter/presentation/components/commons/common_listview.dart';
import 'package:motelhub_flutter/presentation/components/commons/search_bar.dart';
import 'package:motelhub_flutter/presentation/pages/room_detail.dart';

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
    var searchTextController = TextEditingController(text: bloc.roomName);
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        bloc.roomName = value;
                      },
                      decoration: InputDecoration(
                          label: const Text('Room name'),
                          suffixIcon: IconButton(
                              onPressed: () {
                                bloc.add(SearchRoomFindButtonPressed(
                                    searchTextController.text));
                              },
                              icon: const Icon(Icons.search))),
                      controller: searchTextController,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return _buildDialog(context, bloc);
                            });
                      },
                      icon: const Icon(Icons.filter_alt_outlined))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CommonListView(
                  items: bloc.state.data,
                  builder: (context, index) {
                    var item = bloc.state.data![index];
                    return _buildRoomCard(context, item);
                  })
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildDialog(BuildContext context, SearchRoomBloc bloc) {
    var nameTextEditingController = TextEditingController(text: bloc.roomName);
    var addressTextEditingController =
        TextEditingController(text: bloc.address);
    var priceFromTextEditingController =
        TextEditingController(text: bloc.priceFrom.toStringAsFixed(2));
    var priceToTextEditingController =
        TextEditingController(text: bloc.priceTo.toStringAsFixed(2));
    var acreageFromTextEditingController =
        TextEditingController(text: bloc.acreageFrom.toStringAsFixed(2));
    var acreageToTextEditingController =
        TextEditingController(text: bloc.acreageTo.toStringAsFixed(2));
    return AlertDialog(
      scrollable: true,
      title: const Text('Search'),
      contentPadding: const EdgeInsets.all(10),
      content: Column(children: [
        TextField(
          keyboardType: TextInputType.text,
          controller: nameTextEditingController,
          decoration: InputDecoration(
            label: const Text('Room name'),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: addressTextEditingController,
          decoration: InputDecoration(
            label: const Text('Address'),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: priceFromTextEditingController,
                decoration: InputDecoration(
                  label: const Text('From price'),
                  suffixIcon: const Text('VND'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: priceToTextEditingController,
                decoration: InputDecoration(
                  label: const Text('To price'),
                  suffixIcon: const Text('VND'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
          ],
        ), //Price Range
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: acreageFromTextEditingController,
                decoration: InputDecoration(
                  label: const Text('From acreage'),
                  suffixIcon: const Text('M2'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: acreageToTextEditingController,
                decoration: InputDecoration(
                  label: const Text('To acreage'),
                  suffixIcon: const Text('M2'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
      actions: [
        TextButton(
            onPressed: () {
              bloc.add(SearchRoomCloseDialogEvent(
                  roomName: nameTextEditingController.text,
                  address: addressTextEditingController.text,
                  priceFrom: priceFromTextEditingController.text,
                  priceTo: priceToTextEditingController.text,
                  acreageFrom: acreageFromTextEditingController.text,
                  acreageTo: acreageToTextEditingController.text));
              Navigator.of(context).pop();
            },
            child: const Text('Close')),
        TextButton(
            onPressed: () {
              bloc.add(SearchRoomSubmitEvent(
                  roomName: nameTextEditingController.text,
                  address: addressTextEditingController.text,
                  priceFrom: priceFromTextEditingController.text,
                  priceTo: priceToTextEditingController.text,
                  acreageFrom: acreageFromTextEditingController.text,
                  acreageTo: acreageToTextEditingController.text));
              Navigator.of(context).pop();
            },
            child: const Text('Find'))
      ],
    );
  }

  Widget _buildRoomCard(BuildContext context, RoomEntity room) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/room-detail',
          arguments: {'roomId': room.id}),
      child: Card(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListTile(
              title:
                  Text('${room.name} - ${room.address ?? 'not given address'}'),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Host: ${room.ownerName ?? 'host name'}'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Contact: ${room.ownerPhone ?? 'phone number'} - ${room.ownerEmail ?? 'email'}'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Price: ${room.price ?? '0'} VND'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Acreage: ${room.acreage ?? '0'} M2'),
                    const SizedBox(
                      height: 10,
                    ),
                  ]),
            )),
      ),
    );
  }
}
