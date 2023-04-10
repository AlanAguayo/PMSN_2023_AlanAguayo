import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practicauno/database/database_helper.dart';
import 'package:provider/provider.dart';

import '../models/event_model.dart';
import '../provider/flags_provider.dart';
import 'future_modal.dart';

class ItemEventWidget extends StatefulWidget {
  const ItemEventWidget({super.key, this.eventModel});

  final EventModel? eventModel;

  @override
  State<ItemEventWidget> createState() => _ItemEventWidgetState();
}

class _ItemEventWidgetState extends State<ItemEventWidget> {
  final DatabaseHelper _database = DatabaseHelper();

  FlagsProvider? flags;

  @override
  Widget build(BuildContext context) {
    flags = Provider.of<FlagsProvider>(context);

    var iconTrash = const Icon(
      Icons.delete,
      size: 35,
    );

    final cardDesc = Container(
      padding: const EdgeInsets.only(right: 8, left: 8, top: 20, bottom: 8),
      alignment: Alignment.center,
      color: Colors.transparent,
      height: 120,
      child: Text(
        '${widget.eventModel!.dscEvento}',
        textAlign: TextAlign.center,
      ),
    );

    Color color = Colors.transparent;
    defineColor() {
      if (widget.eventModel!.dateEvento != null) {
        var diferencia = int.parse(
                widget.eventModel!.dateEvento!.substring(8)) -
            int.parse(
                DateFormat('yyyy-MM-dd').format(DateTime.now()).substring(8));
        if (widget.eventModel!.completado == 1) {
          color = Colors.green;
        } else {
          if (diferencia < 0) {
            color = Colors.red;
          } else {
            if (diferencia >= 0 && diferencia <= 2) {
              color = Colors.yellow;
            }
          }
        }
      }
    }

    final ribbonBottom = ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerRight,
        height: 40,
        color: defineColor(),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Fecha: ${widget.eventModel!.dateEvento}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            //Container(

            IconButton(
              onPressed: () => _showDeleteModal(context),
              icon: iconTrash,
            ),
          ],
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextButton(
        onPressed: () =>
            openCustomDialog(context, null, widget.eventModel, 'Event', null),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 8),
                color: Colors.transparent,
                blurRadius: 7,
              )
            ],
          ),
          child: Column(
            children: [
              cardDesc,
              ribbonBottom,
              const Divider(color: Colors.white, height: 1, thickness: 2),
            ],
          ),
        ),
      ),
    );
  }

  _showDeleteModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text(
            '¿Desea borrar el evento?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                _database.ELIMINAR(
                    'tblEvent', widget.eventModel!.idEvento!, 'idEvento');
                Navigator.pop(context);
                flags!.setUpdate();
              },
              child: const Text('Aceptar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            )
          ],
        );
      },
    );
  }
}
