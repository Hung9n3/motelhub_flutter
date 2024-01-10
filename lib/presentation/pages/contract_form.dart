import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/contract_form/contract_form_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/contract_form/contract_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/contract_form/contract_form_state.dart';
import 'package:motelhub_flutter/presentation/components/commons/form_container.dart';
import 'package:motelhub_flutter/presentation/components/commons/section_with_bottom_border.dart';

class ContractForm extends StatelessWidget {
  final int? contractId;
  final int? roomId;
  const ContractForm({super.key, required this.roomId, this.contractId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ContractFormBloc>(
              create: (context) => sl()..add(ContractFormInitEvent(contractId))),
        ],
        child: BlocBuilder<ContractFormBloc, ContractFormState>(
            builder: (context, state) {
          if (state is ContractFormLoading) {
            return const Center(child: CupertinoActivityIndicator());
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Contract'),
                actions: [
                  IconButton(
                      onPressed: () {
                        context
                            .read<ContractFormBloc>()
                            .add(const SubmitContractFormEvent());
                      },
                      icon: const Icon(Icons.check))
                ],
              ),
              body: _buildBody(context),
            );
          }
        }));
  }

  _buildBody(BuildContext context) {
    var bloc = context.read<ContractFormBloc>();
    var startDate = bloc.startDate == null
        ? ''
        : DateFormat('dd, MMM y').format(bloc.startDate!);
    var endDate = bloc.endDate == null
        ? ''
        : DateFormat('dd, MMM y').format(bloc.endDate!);
    var cancelDate = bloc.cancelDate == null
        ? ''
        : DateFormat('dd, MMM y').format(bloc.cancelDate!);
    var startDateController = TextEditingController(text: startDate);
    var endDateController = TextEditingController(text: endDate);
    var cancelDateController = TextEditingController(text: cancelDate);
    return FormContainer(
        child: Column(children: [
      DropdownMenu<UserEntity>(
          width: MediaQuery.of(context).size.width >= 800
              ? 740
              : MediaQuery.of(context).size.width - 60,
          leadingIcon: const Icon(Icons.holiday_village),
          initialSelection: bloc.state.selectedOwner,
          requestFocusOnTap: true,
          label: const Text('Select current owner'),
          dropdownMenuEntries: bloc.users
              .map((value) => DropdownMenuEntry<UserEntity>(
                    value: value,
                    label: "${value.name} - ${value.phoneNumber}",
                  ))
              .toList(),
          onSelected: (value) {
            context
                .read<ContractFormBloc>()
                .add(ContractFormChangeOwnerEvent(value));
          }),
          SectionWithBottomBorder(
            child: TextFormField(
          controller: startDateController,
          decoration: InputDecoration(
            suffixText: 'Start date',
            enabled: false,
            prefixIcon: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const Icon(Icons.calendar_month),
            ),
          ),
        )),
    ]));
  }
}
