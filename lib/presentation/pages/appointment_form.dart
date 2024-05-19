import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/appointment_form/appointment_form_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/appointment_form/appointment_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/appointment_form/appointment_form_state.dart';
import 'package:motelhub_flutter/presentation/components/commons/alert_dialog.dart';
import 'package:motelhub_flutter/presentation/components/commons/common_date_picker.dart';
import 'package:motelhub_flutter/presentation/components/commons/form_container.dart';
import 'package:motelhub_flutter/presentation/components/commons/section_with_bottom_border.dart';

class AppointmentForm extends StatelessWidget {
  final int? appointmentId;
  final int? roomId;
  const AppointmentForm({super.key, this.appointmentId, this.roomId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppointmentFormBloc>(
        create: (context) =>
            sl()..add(AppointmentFormInitEvent(appointmentId, roomId)),
        child: BlocConsumer<AppointmentFormBloc, AppointmentFormState>(
          listener: (context, state) {
            if(state is AppointmentFormValidateFail) {
              showAlertDialog(context, state.alert!);
            }
          },
          builder: (context, state) {
            if (state is AppointmentFormErrorState) {
              return Center(
                child: Text("${state.error}"),
              );
            }
            if (state is AppointmentFormLoadingState) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }

            return _buildBody(context);
          },
        ));
  }

  _buildBody(BuildContext context) {
    var bloc = context.read<AppointmentFormBloc>();
    var startDate = bloc.startDate == null
        ? ''
        : DateFormat('dd, MMM y').format(bloc.startDate!);
    var startDateController = TextEditingController(text: startDate);
    var durationController = TextEditingController(text: '${bloc.duration}');
    var startTimeController = TextEditingController(text: '${bloc.startTime?.hour.toString().padLeft(2, '0')}:${bloc.startTime?.minute.toString().padLeft(2, '0')}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment'),
        actions: [
          IconButton(onPressed: (){
            bloc.add(AppointmentFormSubmitEvent(appointmentId, int.tryParse(durationController.text)));
          }, icon: const Icon(Icons.check))
        ],
      ),
      body: FormContainer(
          child: Column(children: [
        SectionWithBottomBorder(
            child: TextField(
          readOnly: true,
          controller: TextEditingController(text: bloc.roomName),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.meeting_room),
          ),
        )),
        SectionWithBottomBorder(
            child: TextField(
          readOnly: true,
          controller: TextEditingController(text: bloc.participantName),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person_add_alt_1),
          ),
        )),
        Row(
          children: [
            Expanded(
              child: 
                SectionWithBottomBorder(
                    child: TextFormField(
                  onTap: () async {
                    var selectedDate = await selectDate(
                        context, DateTime.now(), DateTime(9999), bloc.startDate);
                    bloc.add(AppointmentFormChangeStartDateEvent(selectedDate));
                  },
                  readOnly: true,
                  enabled: bloc.isCanceled != true,
                  controller: startDateController,
                  decoration: const InputDecoration(
                    suffixText: 'Start date',
                    prefixIcon: Icon(Icons.calendar_month),
                  ),
                )),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: 
                SectionWithBottomBorder(
                    child: TextFormField(
                  onTap: () async {
                    var selectedTime = await selectTime(
                        context, bloc.startTime ?? TimeOfDay.now());
                    bloc.add(AppointmentFormChangeStartTimeEvent(selectedTime));
                  },
                  readOnly: true,
                  enabled: appointmentId == null || bloc.isCanceled != true && bloc.currentUserId == bloc.creatorId,
                  controller: startTimeController,
                  decoration: const InputDecoration(
                    suffixText: 'Start time',
                    prefixIcon: Icon(Icons.access_time),
                  ),
                )),
            ),
          ],
        ),
        SectionWithBottomBorder(
            child: TextField(
          enabled: appointmentId == null || bloc.isCanceled != true && bloc.currentUserId == bloc.creatorId,
          controller: durationController,
          decoration: const InputDecoration(
            suffixText: 'Minutes',
            prefixIcon: Icon(Icons.timelapse),
          ),
        )),
        Row(
          children: [
            const Text('Canceled'),
            const SizedBox(width: 10,),
            Switch(
                  value: bloc.isCanceled ?? false,
                  onChanged: (value) {
                    bloc
                        .add(AppointmentFormIsCancelChangeEvent(value));
                  }),
          ],
        ),
        Row(
          children: [
            const Text('Accepted'),
            const SizedBox(width: 10,),
            Switch(
                  value: bloc.isAccepted ?? false,
                  onChanged: (value) {
                    bloc
                        .add(AppointmentFormIsAcceptedChangeEvent(value));
                  }),
          ],
        ),
      ])),
    );
  }
}
