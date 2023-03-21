import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../database/database_helper.dart';
import '../models/event_model.dart';
import '../provider/flags_provider.dart';

class ModalAddEvent extends StatefulWidget {
  ModalAddEvent({super.key, this.eventModel});

  final EventModel? eventModel;

  @override
  State<ModalAddEvent> createState() => _ModalAddEventState();
}

class _ModalAddEventState extends State<ModalAddEvent> {
  DatabaseHelper? database;
  TextEditingController txtDescEvent = TextEditingController();
  DateTime selectedDate = DateTime.now();

  String selectedDateFormat = "";

  @override
  void initState() {
    super.initState();
    database = DatabaseHelper();
    txtDescEvent.text =
        widget.eventModel != null ? widget.eventModel!.dscEvento! : "";
    selectedDateFormat = widget.eventModel != null
        ? widget.eventModel!.dateEvento!
        : DateFormat('yyyy-MM-dd').format(DateTime.now());
    selectedDate = widget.eventModel != null
        ? DateTime.parse(widget.eventModel!.dateEvento!)
        : DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020, 01),
      lastDate: DateTime(2025, 12),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedDateFormat = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flags = Provider.of<FlagsProvider>(context);

    return AlertDialog(
        title: widget.eventModel == null
            ? const Text('Adding Event')
            : const Text('Editing Event'),
        content: SizedBox(
          height: 215,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: txtDescEvent,
                maxLines: 5,
              ),
              TextButton(
                onPressed: () => _selectDate(context),
                child: Text('Fecha: $selectedDateFormat'),
              ),
              IconButton(
                onPressed: () {
                  if (widget.eventModel == null) {
                    database!.INSERTAR("tblEvent", {
                      'dscEvento': txtDescEvent.text,
                      'fechaEvento':
                          DateFormat('yyyy-MM-dd').format(selectedDate),
                      'completado': 0,
                    }).then((value) {
                      var msg = value > 0
                          ? 'Evento Programado!'
                          : 'Ocurrio un error!';
                      final snackBar = SnackBar(content: Text(msg));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flags.setUpdate();
                    });
                  } else {
                    database!
                        .ACTUALIZAR(
                            "tblEvent",
                            {
                              'idEvento': widget.eventModel!.idEvento,
                              'dscEvento': txtDescEvent.text,
                              'fechaEvento':
                                  DateFormat('yyyy-MM-dd').format(selectedDate),
                              'completado': 0,
                            },
                            'idEvento')
                        .then((value) {
                      var msg =
                          value > 0 ? 'Evento editado!' : 'Ocurrio un error!';
                      final snackBar = SnackBar(content: Text(msg));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flags.setUpdate();
                    });
                  }
                },
                icon: widget.eventModel != null
                    ? Icon(Icons.navigate_next)
                    : Icon(Icons.add),
              )
            ],
          ),
        ),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ));
  }
}
