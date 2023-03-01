import 'package:flutter/material.dart';

import '../models/post_model.dart';

class ItemPostWidget extends StatelessWidget {
  ItemPostWidget({super.key, this.postModel});
  final PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    const iconMore = Icon(
      Icons.more_horiz,
      size: 35,
    );

    final cardDesc = Container(
      color: Colors.green,
      height: 160,
    );

    const rowFooter = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Fecha: '),
        Icon(Icons.thumb_up),
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
        child: iconMore,
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
}
