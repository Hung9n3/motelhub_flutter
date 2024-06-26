import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:motelhub_flutter/domain/entities/bill.dart';
import 'package:motelhub_flutter/domain/entities/user.dart';
import 'package:motelhub_flutter/injection_container.dart';
import 'package:motelhub_flutter/presentation/blocs/contract_form/contract_form_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/contract_form/contract_form_event.dart';
import 'package:motelhub_flutter/presentation/blocs/contract_form/contract_form_state.dart';
import 'package:motelhub_flutter/presentation/components/commons/alert_dialog.dart';
import 'package:motelhub_flutter/presentation/components/commons/common_date_picker.dart';
import 'package:motelhub_flutter/presentation/components/commons/common_listview.dart';
import 'package:motelhub_flutter/presentation/components/commons/form_container.dart';
import 'package:motelhub_flutter/presentation/components/commons/item_expansion.dart';
import 'package:motelhub_flutter/presentation/components/commons/section_with_bottom_border.dart';
import 'package:motelhub_flutter/presentation/components/commons/swipeable_with_delete_button.dart';
import 'package:motelhub_flutter/presentation/pages/bill_form.dart';
import 'package:signature/signature.dart';

class ContractForm extends StatelessWidget {
  final int? contractId;
  final int? roomId;
  const ContractForm({super.key, required this.roomId, this.contractId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ContractFormBloc>(
              create: (context) =>
                  sl()..add(ContractFormInitEvent(contractId, roomId))),
        ],
        child: BlocConsumer<ContractFormBloc, ContractFormState>(
            listener: (context, state) {
              if(state is SubmitContractFormDone) {
                showAlertDialog(context, "Save successfully");
              }
              if(state is SubmitContractFormFail) {
                showAlertDialog(context, "Save failed");
              }
            },
            builder: (context, state) {
              var priceController = TextEditingController(
                  text: context.read<ContractFormBloc>().priceRoom?.toString());
              if (state is ContractFormLoading) {
                return const Center(child: CupertinoActivityIndicator());
              } else {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Contract'),
                    actions: [
                      IconButton(
                          onPressed: () {
                            context.read<ContractFormBloc>().add(
                                SubmitContractFormEvent(priceController.text));
                          },
                          icon: const Icon(Icons.check))
                    ],
                  ),
                  body: _buildBody(context, priceController),
                );
              }
            }));
  }

  _buildBody(BuildContext context, TextEditingController priceController) {
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
          initialSelection: bloc.state.selectedCustomer,
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
        readOnly: bloc.signature != null,
        controller: priceController,
        onChanged: (value) {
          bloc.priceRoom = double.tryParse(value);
        },
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.attach_money), suffixText: 'VND'),
      )),
      SectionWithBottomBorder(
          child: TextFormField(
        onTap: () async {
          var selectedDate = await selectDate(
              context, DateTime.now(), DateTime(9999), bloc.startDate);
          bloc.add(ContractFormChangeStartDateEvent(selectedDate));
        },
        readOnly: true,
        enabled: contractId == null || bloc.startDate == null,
        controller: startDateController,
        decoration: InputDecoration(
          suffixText: 'Start date',
          prefixIcon: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: const Icon(Icons.calendar_month),
          ),
        ),
      )),
      SectionWithBottomBorder(
          child: TextFormField(
        onTap: () async {
          var selectedDate = await selectDate(
              context, bloc.startDate, DateTime(9999), bloc.endDate);
          bloc.add(ContractFormChangeEndDateEvent(selectedDate));
        },
        readOnly: true,
        enabled: contractId == null || bloc.endDate == null,
        controller: endDateController,
        decoration: InputDecoration(
          suffixText: 'End date',
          prefixIcon: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: const Icon(Icons.calendar_month),
          ),
        ),
      )),
      SectionWithBottomBorder(
          child: TextFormField(
        onTap: () async {
          var selectedDate = await selectDate(
              context, bloc.startDate, bloc.endDate, bloc.cancelDate);
          bloc.add(ContractFormChangeCancelDateEvent(selectedDate));
        },
        readOnly: true,
        enabled: bloc.endDate != null && bloc.startDate != null,
        controller: cancelDateController,
        decoration: InputDecoration(
          suffixText: 'Cancel date',
          prefixIcon: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: const Icon(Icons.calendar_month),
          ),
        ),
      )),
      TextButton(
          onPressed: () async {
            final SignatureController _controller = SignatureController(
              penStrokeWidth: 5,
              penColor: Colors.black,
              exportBackgroundColor: Colors.transparent,
            );
            var signature = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: false,
                    contentPadding: const EdgeInsets.all(8.0),
                    content: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: bloc.signature == null ? Signature(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        controller: _controller,
                        backgroundColor: Colors.white,
                      ) : Image.memory(bloc.signature!),
                    ),
                    actions: [
                      Visibility(
                        visible: bloc.signature == null,
                        child: ElevatedButton(
                            onPressed: () {
                              //bloc.add(const DeleteSignatureEvent());
                              _controller.clear();
                            },
                            child: const Text('Delete')),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel')),
                      ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context, await _controller.toPngBytes());
                          },
                          child: const Text('Save')),
                    ],
                  );
                });   
                if(signature != null) {
                  bloc.signature = signature;
                }     
                print(bloc.signature == null);      
          },
          child: const Text('Customer signature')),
      Visibility(
          visible: contractId != null,
          child: _billSection(context, bloc.bills)),
    ]));
  }

  Widget _billSection(BuildContext context, List<BillEntity>? bills) {
    if (bills == null) {
      return const SizedBox();
    }
    return Visibility(
      visible: contractId != null,
      child: ItemExpansion(
        itemCount: bills.length,
        title: 'Bill',
        icon: Icons.receipt_long,
        children: [
          OutlinedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BillForm(contractId: contractId))).then((value) => context.read<ContractFormBloc>().add(ContractFormInitEvent(contractId, roomId))),
              child: const Icon(Icons.add)),
          CommonListView(
              items: bills,
              builder: (context, index) {
                var bill = bills[index];
                return SwipeableWithDeleteButton(
                    child: _billCard(context, bill));
              })
        ],
      ),
    );
  }

  Widget _billCard(BuildContext context, BillEntity? bill) {
    if (bill == null) {
      return const SizedBox();
    }
    var startDate = bill.startDate == null
        ? ''
        : DateFormat('dd, MMM y').format(bill.startDate!);
    var endDate = bill.endDate == null
        ? ''
        : DateFormat('dd, MMM y').format(bill.endDate!);
    var waterLast = bill.waterLast ?? 0.0;
    var waterCurrent = bill.waterCurrent ?? 0.0;
    var waterPrice = bill.waterPrice ?? 0.0;
    var electricPrice = bill.electricPrice ?? 0.0;
    var electricLast = bill.electricLast ?? 0.0;
    var electricCurrent = bill.electricCurrent ?? 0.0;
    var roomPrice = bill.rentPrice ?? 0.0;
    var total = (waterCurrent - waterLast) * waterPrice + (electricCurrent - electricLast) * electricPrice + roomPrice;
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  BillForm(billId: bill.id, contractId: contractId))),
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width >= 800
              ? 800
              : MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8),
          child: ListTile(
            title: Text( bill.electricFrom != null ? 'Bill for ${DateFormat('MMM').format(bill.electricFrom!)}' : ''),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Total: $total')
            ]),
          ),
        ),
      ),
    );
  }
}
