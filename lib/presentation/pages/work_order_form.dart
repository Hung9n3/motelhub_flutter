import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motelhub_flutter/core/constants/constants.dart';
import 'package:motelhub_flutter/domain/entities/work_order.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_event.dart';
import 'package:motelhub_flutter/presentation/blocs/photo_section_bloc/photo_section_state.dart';
import 'package:motelhub_flutter/presentation/blocs/work_order_form/work_order_form_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/work_order_form/work_order_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/work_order_form/work_order_form_state.dart';
import 'package:motelhub_flutter/presentation/components/commons/alert_dialog.dart';
import 'package:motelhub_flutter/presentation/components/commons/form_container.dart';
import 'package:motelhub_flutter/presentation/components/commons/photo_section.dart';
import 'package:motelhub_flutter/presentation/components/commons/section_with_bottom_border.dart';

class WorkOrderForm extends StatelessWidget {
  final int? workOrderId;
  final int? roomId;

  const WorkOrderForm({super.key, this.workOrderId, this.roomId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<WorkOrderFormBloc>(
              create: (context) =>
                  sl()..add(WorkOrderFormInitEvent(workOrderId, roomId))),
          BlocProvider<PhotoSectionBloc>(create: (context) => sl()),
        ],
        child: BlocConsumer<WorkOrderFormBloc, WorkOrderFormState>(
          listener: (context, state) {
            if(state is WorkOrderSubmitDone) {
              showAlertDialog(context, saveSuccess);
            }
            if(state is WorkOrderFormErrorState) {
              showAlertDialog(context, 'Techinical Error');
            }
          },
          builder: (context, state) {
            var bloc = context.read<WorkOrderFormBloc>();
            var nameController = TextEditingController(text: bloc.name);
            var priceController =
                TextEditingController(text: bloc.price.toString());
            return Scaffold(
              appBar: AppBar(title: const Text('Work Order'), actions: [
                Visibility(
                  visible: bloc.isOpen,
                  child: IconButton(
                      onPressed: () {
                        var photos =
                            context.read<PhotoSectionBloc>().state.photos;
                        bloc.add(WorkOrderFormSubmitEvent(nameController.text,
                            double.tryParse(priceController.text), photos));
                      },
                      icon: const Icon(Icons.check)),
                )
              ]),
              floatingActionButton: Visibility(
                visible: bloc.isOpen,
                child: IconButton(
                  onPressed: () {
                    context
                      .read<PhotoSectionBloc>()
                      .add(const AddPhotoEvent(ImageSource.camera));
                  },
                  icon: const Icon(Icons.add_a_photo),
                ),
              ),
              body: _buildBody(context, nameController, priceController),
            );
          },
        ));
  }

  Widget _buildBody(BuildContext context, TextEditingController nameController,
      TextEditingController priceController) {
    var workOrderFormBloc = context.read<WorkOrderFormBloc>();
    return FormContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionWithBottomBorder(
            child: TextField(
          readOnly: !workOrderFormBloc.isOpen && !workOrderFormBloc.isCreator,
          controller: nameController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.report_gmailerrorred),
          ),
        )),
        SectionWithBottomBorder(
            child: TextField(
          readOnly: true,
          controller: TextEditingController(text: workOrderFormBloc.roomName),
          decoration: const InputDecoration(
              hintText: 'Room name',
              prefixIcon: Icon(Icons.meeting_room_rounded)),
        )),
        SectionWithBottomBorder(
            child: TextField(
          readOnly: !workOrderFormBloc.isOpen,
          controller: priceController,
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.attach_money), suffixText: 'VND'),
        )),
        BlocBuilder<WorkOrderFormBloc, WorkOrderFormState>(
            builder: (context, state) {
          return Row(
            children: [
              const Text('Opening'),
              const SizedBox(width: 10,),
              Switch(
                  value: workOrderFormBloc.isOpen,
                  onChanged: (value) {
                    workOrderFormBloc
                        .add(WorkOrderFormIsCustomerPayChangedEvent(value));
                  }),
            ],
          );
        }),
        const PhotoSection()
      ],
    ));
  }
}
