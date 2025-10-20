import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/event.dart';
import '../models/memo.dart';
import '../models/task.dart';

class MessagePreviewTile extends StatelessWidget {
  final dynamic item;
  final VoidCallback? onTap;

  const MessagePreviewTile({
    Key? key,
    required this.item,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title;
    String subtitle;
    Widget? leading;

    if (item is Memo) {
      leading = Icon(CupertinoIcons.mail);
      title = (item as Memo).message;
      subtitle = (item as Memo).author;
    } else if (item is Event) {
      leading = Icon(CupertinoIcons.calendar);
      title = (item as Event).title;
      subtitle = (item as Event).organizer;
    } else if (item is Task) {
      leading = Icon(CupertinoIcons.checkmark_rectangle);
      title = (item as Task).title;
      subtitle = (item as Task).status;
    } else {
      leading = Icon(CupertinoIcons.question);
      title = 'Unknown item';
      subtitle = '';
    }

    return CupertinoListTile(
      leading: leading,
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
    );
  }

}