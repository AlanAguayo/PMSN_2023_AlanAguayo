import 'package:flutter/material.dart';
import 'package:practicauno/widgets/modal_add_event.dart';

import '../models/event_model.dart';
import '../models/post_model.dart';
import 'modal_add_post.dart';

openCustomDialog(BuildContext context, PostModel? postModel,
    EventModel? eventModel, String type) {
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return Transform.scale(
        scale: animation.value,
        child: Opacity(
          opacity: animation.value,
          child: type == 'Event'
              ? ModalAddEvent(eventModel: eventModel)
              : ModalAddPost(postModel: postModel),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
    barrierDismissible: true,
    barrierLabel: '',
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container();
    },
  );
}
