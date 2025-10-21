import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/event.dart';
import '../models/memo.dart';
import '../models/task.dart';

class MessagePreviewTile extends StatelessWidget {
  final dynamic item;
  final VoidCallback? onTap;

  const MessagePreviewTile({Key? key, required this.item, this.onTap})
    : super(key: key);

  String _formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('hh:mm a');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    String title;
    String subtitle;
    IconData iconData;
    DateTime? createdAt;

    if (item is Memo) {
      iconData = CupertinoIcons.mail;
      title = (item as Memo).message;
      subtitle = (item as Memo).author;
      createdAt = (item as Memo).createdAt;
    } else if (item is Event) {
      iconData = CupertinoIcons.calendar;
      title = (item as Event).title;
      subtitle = (item as Event).organizer;
      createdAt = (item as Event).createdAt;
    } else if (item is Task) {
      iconData = CupertinoIcons.checkmark_rectangle;
      title = (item as Task).title;
      subtitle = (item as Task).status;
      createdAt = (item as Task).createdAt;
    } else {
      iconData = CupertinoIcons.question;
      title = 'Unknown item';
      subtitle = '';
    }

    return CupertinoListTile(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      leading: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey2,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(iconData, size: 22, color: CupertinoColors.black),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: CupertinoColors.black,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 14, color: CupertinoColors.systemGrey),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (createdAt != null)
            Text(
              _formatDateTime(createdAt),
              style: const TextStyle(
                fontSize: 12,
                color: CupertinoColors.systemGrey,
              ),
            ),
          const SizedBox(height: 4),
          const Icon(
            CupertinoIcons.chevron_forward,
            size: 16,
            color: CupertinoColors.systemGrey,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
