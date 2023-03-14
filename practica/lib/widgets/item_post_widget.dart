import 'package:flutter/material.dart';
import 'package:practicauno/database/database_helper.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';
import '../provider/flags_provider.dart';
import 'future_modal.dart';

class ItemPostWidget extends StatefulWidget {
  ItemPostWidget({super.key, this.postModel});

  final PostModel? postModel;

  @override
  State<ItemPostWidget> createState() => _ItemPostWidgetState();
}

class _ItemPostWidgetState extends State<ItemPostWidget> {
  final DatabaseHelper _database = DatabaseHelper();

  FlagsProvider? flags;

  @override
  Widget build(BuildContext context) {
    flags = Provider.of<FlagsProvider>(context);

    final iconMore = Icon(
      Icons.more_horiz,
      size: 35,
    );

    final cardDesc = Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      color: Colors.green,
      height: 160,
      child: Text(
        '${widget.postModel!.dscPost}',
        textAlign: TextAlign.center,
      ),
    );

    final rowFooter = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Fecha: ${widget.postModel!.datePost}',
          style: const TextStyle(fontSize: 18),
        ),
        const Icon(Icons.thumb_up),
      ],
    );

    final ribbonTop = ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        height: 40,
        color: Colors.green[400],
        width: double.infinity,
        child: PopupMenuButton(
          itemBuilder: (context) {
            return const [
              PopupMenuItem<int>(
                value: 1,
                child: Text('Editar'),
              ),
              PopupMenuItem<int>(
                value: 0,
                child: Text('Borrar'),
              ),
            ];
          },
          onSelected: (value) {
            switch (value) {
              case 0:
                _showDeleteModal(context);
                break;
              case 1:
                openCustomDialog(context, widget.postModel);
                break;
            }
          },
          icon: iconMore,
        ),
      ),
    );

    final ribbonBottom = ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        color: Colors.green[400],
        width: double.infinity,
        child: rowFooter,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 250,
        //height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 8),
              color: Colors.grey,
              blurRadius: 7,
            )
          ],
        ),
        child: Column(
          children: [
            ribbonTop,
            cardDesc,
            ribbonBottom,
          ],
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
            '¿Desea borrar el post?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                _database.ELIMINAR('tblPost', widget.postModel!.idPost!);
                Navigator.pop(context);
                flags!.setUpdatePost();
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

  _showUpdateModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text(
            'Editar',
          ),
          actions: [
            TextButton(
              onPressed: () {
                _database.ELIMINAR('tblPost', widget.postModel!.idPost!);
                Navigator.pop(context);
                flags!.setUpdatePost();
              },
              child: const Text('Aceptar'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Cancelar'),
            )
          ],
        );
      },
    );
  }
}
