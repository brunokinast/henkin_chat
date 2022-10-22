import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final QueryDocumentSnapshot message;
  final bool isMine;

  const MessageBubble(this.message, this.isMine, Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color bubbleColor = Color(message.get('color') as int);
    final Color textColor =
        bubbleColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    return Row(
      mainAxisAlignment:
          isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //     offset: Offset(isMine ? -3 : 3, 3),
            //     blurRadius: 5,
            //     color: Theme.of(context).primaryColorDark.withOpacity(0.2),
            //   ),
            // ],
            border: Border.all(
                width: 1,
                color: HSLColor.fromColor(bubbleColor)
                    .withLightness(0.8)
                    .toColor()),
            color: bubbleColor,
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(10),
              bottomRight: const Radius.circular(10),
              topRight: isMine ? Radius.zero : const Radius.circular(10),
              topLeft: isMine ? const Radius.circular(10) : Radius.zero,
            ),
          ),
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width / 4,
            maxWidth: MediaQuery.of(context).size.width / 1.5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMine)
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    message.get('name') as String,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .subtitle2!
                        .copyWith(color: textColor),
                  ),
                ),
              Text(
                message.get('text') as String,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: textColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
