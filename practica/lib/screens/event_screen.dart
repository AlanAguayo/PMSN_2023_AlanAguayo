import 'package:flutter/material.dart';
import 'package:practicauno/screens/list_event_screen.dart';
import 'package:practicauno/widgets/future_modal.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../database/database_helper.dart';
import '../provider/flags_provider.dart';
import '../provider/theme_provider.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  var currentScreen = 1;

  Map<String, List> mySelectedEvents = {};

  final descController = TextEditingController();

  DatabaseHelper? helper;

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;
    loadPreviousEvents();
  }

  loadPreviousEvents() {
    //Recupera eventos
    mySelectedEvents = {
      "2022-09-9": [
        {"eventDesc": "11"},
        {"eventDesc": "22"},
      ],
      "2022-09-30": [
        {"eventDesc": "22"},
      ],
    };
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Agrega un evento!',
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: descController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Descripcion',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            child: const Text('Agregar'),
            onPressed: () {
/*
              if (descController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Ingrese una descripcion',
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              } else {
                if (mySelectedEvents[
                        DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
                    null) {
                  mySelectedEvents[
                          DateFormat('yyyy-MM-dd').format(_selectedDate!)]
                      ?.add({'eventDesc': descController.text});
                } else {
                  mySelectedEvents[
                      DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
                    {
                      "eventDesc": descController.text,
                    }
                  ];
                }

                setState(() {
                  if (mySelectedEvents[
                          DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
                      null) {
                    mySelectedEvents[
                            DateFormat('yyyy-MM-dd').format(_selectedDate!)]
                        ?.add({"eventDesc": descController.text});
                  }
                });
                //Guarda cosas
                descController.clear();
                Navigator.pop(context);
                return;
              }*/
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flags = Provider.of<FlagsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (currentScreen == 1) {
                currentScreen = 0;
              } else {
                currentScreen = 1;
              }
              setState(() {});
            },
            icon: currentScreen == 1
                ? Icon(Icons.list)
                : Icon(Icons.calendar_month),
          )
        ],
        centerTitle: true,
        title: const Text('Eventos'),
      ),
      body: currentScreen == 1 ? calendarWidget() : ListEventScreen(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => openCustomDialog(context, null, null, 'Event'),
        label: const Text('New Event!'),
        icon: const Icon(Icons.add_comment),
      ),
    );
  }

  Column calendarWidget() {
    return Column(
      children: [
        Text(
          'Administra tus eventos',
          style: TextStyle(fontSize: 24),
        ),
        TableCalendar(
          firstDay: DateTime(2023),
          lastDay: DateTime(2030),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDate, selectedDay)) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDate, day);
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          eventLoader: _listOfDayEvents,
        ),
        ..._listOfDayEvents(_selectedDate!).map(
          (event) => ListTile(
            leading: const Icon(
              Icons.done,
              color: Colors.teal,
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text('Event Title: ${event['eventDesc']}'),
            ),
          ),
        ),
      ],
    );
  }
}
