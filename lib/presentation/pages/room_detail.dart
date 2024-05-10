import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motelhub_flutter/core/enums/option_sets.dart';
import 'package:motelhub_flutter/domain/entities/appointment.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/domain/entities/contract.dart';
import 'package:motelhub_flutter/domain/entities/work_order.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:intl/intl.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_event.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_event.dart';
import 'package:motelhub_flutter/presentation/blocs/room_detail/room_detail_state.dart';
import 'package:motelhub_flutter/presentation/components/commons/common_listview.dart';
import 'package:motelhub_flutter/presentation/components/commons/form_container.dart';
import 'package:motelhub_flutter/presentation/components/commons/item_expansion.dart';
import 'package:motelhub_flutter/presentation/components/commons/photo_section.dart';
import 'package:motelhub_flutter/presentation/components/commons/section_with_bottom_border.dart';
import 'package:motelhub_flutter/presentation/pages/contract_form.dart';

class RoomDetailPage extends StatelessWidget {
  final int roomId;
  bool isFirstBuild = true;

  RoomDetailPage({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<RoomDetailBloc>(
              create: (context) => sl()..add(LoadFormDataEvent(roomId))),
          BlocProvider<PhotoSectionBloc>(create: (context) => sl()),
        ],
        child: Builder(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Room'), actions: [
              IconButton(
                  onPressed: () {
                    var photos = context.read<PhotoSectionBloc>().state.photos;
                    context.read<RoomDetailBloc>().add(SubmitFormEvent(photos));
                  },
                  icon: const Icon(Icons.check))
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context
                    .read<PhotoSectionBloc>()
                    .add(const AddPhotoEvent(ImageSource.camera));
              },
              child: const Icon(Icons.add_a_photo),
            ),
            body: _buildBody(context),
          );
        }));
  }

  _buildBody(BuildContext context) {
    var roomDetailBloc = context.read<RoomDetailBloc>();
    var photoSectionBloc = context.read<PhotoSectionBloc>();
    return BlocBuilder<RoomDetailBloc, RoomDetailState>(
      builder: (context, state) {
        if (state is RoomDetailLoadingFormState) {
          return const CupertinoActivityIndicator();
        } else {
          if (isFirstBuild) {
            photoSectionBloc.add(UpdatePhotosEvent(roomDetailBloc.photos));
            isFirstBuild = false;
          }
          return FormContainer(
            child: Column(
              children: [
                DropdownMenu<UserEntity>(
                    width: MediaQuery.of(context).size.width >= 800
                        ? 740
                        : MediaQuery.of(context).size.width - 60,
                    leadingIcon: const Icon(Icons.person),
                    initialSelection: roomDetailBloc.users
                        .where(
                            (element) => element.id == roomDetailBloc.ownerId)
                        .firstOrNull,
                    requestFocusOnTap: true,
                    label: const Text('Select owner'),
                    dropdownMenuEntries: roomDetailBloc.users
                        .map((value) => value.id == 0
                            ? DropdownMenuEntry(
                                value: value, label: '${value.name}')
                            : DropdownMenuEntry<UserEntity>(
                                value: value,
                                label: "${value.name} - ${value.phoneNumber}",
                              ))
                        .toList(),
                    onSelected: (value) {
                      roomDetailBloc.add(ChangeOwnerEvent(value));
                    }),
                SectionWithBottomBorder(
                    child: TextFormField(
                  initialValue: roomDetailBloc.areaName,
                  decoration: const InputDecoration(
                    enabled: false,
                    prefixIcon: Icon(Icons.holiday_village),
                  ),
                )),
                SectionWithBottomBorder(
                    child: TextFormField(
                  initialValue: roomDetailBloc.name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.meeting_room),
                  ),
                  onChanged: (value) =>
                      roomDetailBloc.add(ChangeNameEvent(value)),
                )),
                SectionWithBottomBorder(
                    child: TextFormField(
                  initialValue: roomDetailBloc.acreage?.toString(),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.meeting_room),
                  ),
                  onChanged: (value) =>
                      roomDetailBloc.add(ChangeAcreageEvent(value)),
                )),
                _workOrderSection(context, roomDetailBloc.workOrders),
                _contractSection(context, roomDetailBloc.contracts),
                const PhotoSection(),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _workOrderSection(
      BuildContext context, List<WorkOrderEntity>? workOrders) {
    if (workOrders == null) {
      return const SizedBox();
    }
    return ItemExpansion(
        title: 'Contracts',
        icon: Icons.description,
        itemCount: workOrders.length,
        children: [
          OutlinedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContractForm(roomId: roomId))),
              child: const Icon(Icons.add)),
          CommonListView(
              items: workOrders,
              builder: (context, index) {
                var workOrder = workOrders[index];
                return Slidable(
                    endActionPane: ActionPane(
                        extentRatio: 0.2,
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          )
                        ]),
                    child: workOrderCard(context, workOrder));
              })
        ]);
  }

  Widget _contractSection(
      BuildContext context, List<ContractEntity>? contracts) {
    if (contracts == null) {
      return const SizedBox();
    }
    return ItemExpansion(
        title: 'Contracts',
        icon: Icons.description,
        itemCount: contracts.length,
        children: [
          OutlinedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContractForm(roomId: roomId))),
              child: const Icon(Icons.add)),
          CommonListView(
              items: contracts,
              builder: (context, index) {
                var contract = contracts[index];
                return Slidable(
                    endActionPane: ActionPane(
                        extentRatio: 0.2,
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          )
                        ]),
                    child: contractCard(context, contract));
              })
        ]);
  }

  Widget workOrderCard(BuildContext context, WorkOrderEntity workOrder) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width >= 800
              ? 800
              : MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8),
          child: ListTile(
            title: Text('${workOrder.name}'),
            subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status : ${workOrder.isOpen == true ? 'Opening' : 'Closed'}'),
                  Text('Created On: ${workOrder.createdOn?.toString == null ? '' : DateFormat('dd, MMM y').format(workOrder.createdOn!)}')
                ]),
          ),
        ),
      ),
    );
  }

  Widget contractCard(BuildContext context, ContractEntity contract) {
    var startDate = contract.startDate == null
        ? ''
        : DateFormat('dd, MMM y').format(contract.startDate!);
    var endDate = contract.endDate == null
        ? ''
        : DateFormat('dd, MMM y').format(contract.endDate!);
    var cancelDate = contract.cancelDate == null
        ? ''
        : DateFormat('dd, MMM y').format(contract.cancelDate!);
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ContractForm(roomId: roomId, contractId: contract.id)
                  )),
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width >= 800
              ? 800
              : MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8),
          child: ListTile(
            title: Text('${contract.owner?.name}'),
            subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Duration : $startDate - $endDate'),
                  Text('Cancel On: $cancelDate')
                ]),
          ),
        ),
      ),
    );
  }
}
