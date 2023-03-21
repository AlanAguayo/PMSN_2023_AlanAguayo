import 'package:flutter/material.dart';
import 'package:practicauno/database/database_helper.dart';

import '../models/event_model.dart';
import '../widgets/item_event_widget.dart';

class ListEventScreen extends StatefulWidget {
  const ListEventScreen({super.key});

  @override
  State<ListEventScreen> createState() => _ListEventScreenState();
}

class _ListEventScreenState extends State<ListEventScreen> {
  DatabaseHelper? helper;

  @override
  void initState() {
    super.initState();
    helper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: helper!.GETALLEVENT(),
      builder: (context, AsyncSnapshot<List<EventModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var objEventModel = snapshot.data![index];
              return ItemEventWidget(eventModel: objEventModel);
            },
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Hubo un error :('),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
