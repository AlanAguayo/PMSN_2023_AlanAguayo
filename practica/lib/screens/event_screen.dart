import 'package:flutter/material.dart';
import 'package:practicauno/models/event_model.dart';
import 'package:practicauno/screens/list_event_screen.dart';
import 'package:practicauno/widgets/future_modal.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../database/database_helper.dart';

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

  defineEventColor(EventModel eventModel) {
    if (eventModel.dateEvento != null) {
      var diferencia = int.parse(eventModel.dateEvento!.substring(8)) -
          int.parse(
              DateFormat('yyyy-MM-dd').format(DateTime.now()).substring(8));
      if (eventModel.completado == 1) {
        return Colors.green;
      } else {
        if (diferencia < 0) {
          return Colors.red;
        } else {
          if (diferencia >= 0 && diferencia <= 2) {
            return Colors.yellow;
          }
          return Colors.white70;
        }
      }
    }
  }

  final descController = TextEditingController();

  DatabaseHelper? helper;
  EventModel? oEventModel;

  Map<DateTime, List>? events;
  List<EventModel> eventDetails = List.empty();

  @override
  void initState() {
    super.initState();
    events = {};
    helper = DatabaseHelper();
    _selectedDate = _focusedDay;
    _loadDayEvent(_focusedDay);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDate, selectedDay)) {
      setState(() {
        _selectedDate = selectedDay;
        _focusedDay = focusedDay;
        _loadDayEvent(selectedDay);
      });
    }
  }

  Map<DateTime, List<dynamic>> _fromModelToEvent(List<EventModel> events) {
    Map<DateTime, List<dynamic>> data = {};
    for (var event in events) {
      DateTime date = DateTime.parse(event.dateEvento!);
      if (data[date] == null) data[date] = [];
      data[date]?.add(event);
    }
    return data;
  }

  _loadDayEvent(DateTime day) async {
    return eventDetails = (await helper!.GETDAYEVENT(day)).cast<EventModel>();
  }

  List _eventsDay(DateTime day) {
    return events![day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
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
                ? const Icon(Icons.list)
                : const Icon(Icons.calendar_month),
          )
        ],
        centerTitle: true,
        title: const Text('Eventos'),
      ),
      //calendarWidget
      body: currentScreen == 1 ? calendarWidget() : const ListEventScreen(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            openCustomDialog(context, null, null, 'Event', _focusedDay),
        label: const Text('New Event!'),
        icon: const Icon(Icons.add_comment),
      ),
    );
  }

  FutureBuilder<List<EventModel>> calendarWidget() {
    return FutureBuilder<List<EventModel>>(
        future: helper!.GETALLEVENT(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<EventModel> allEvents = snapshot.data!;
            if (allEvents.isNotEmpty) {
              events = _fromModelToEvent(allEvents);
            }
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Administra tus eventos',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                TableCalendar(
                  calendarFormat: _calendarFormat,
                  focusedDay: _focusedDay,
                  onCalendarCreated: (pageController) {
                    _loadDayEvent(_selectedDate!);
                  },
                  calendarStyle: const CalendarStyle(
                      markerDecoration: BoxDecoration(color: Colors.amber)),
                  firstDay: DateTime(2023),
                  lastDay: DateTime(2030),
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
                  onDaySelected: _onDaySelected,
                  availableGestures: AvailableGestures.all,
                  eventLoader: _eventsDay,
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Eventos de ${DateFormat('yyyy-MM-dd').format(_focusedDay)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...eventDetails.map((event) => eventDetails.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 110),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                openCustomDialog(
                                    context, null, event, 'Event', null);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: defineEventColor(event),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0, 2),
                                          blurRadius: 2.0)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      event.dscEvento.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.0),
                        child: Text(
                          'No hay eventos disponibles',
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
              ],
            ),
          );
        });
  }
}
