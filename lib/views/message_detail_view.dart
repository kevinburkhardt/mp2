import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/event.dart';
import '../models/memo.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

class MessageDetailView extends StatelessWidget {
  final dynamic message;

  const MessageDetailView({Key? key, required this.message}) : super(key: key);

  String _formatDate(DateTime date) {
    return DateFormat('EEE, MMM d, h:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    if (message is Memo) {
      final memo = message as Memo;
      return _buildMemoDetail(context, memo);
    } else if (message is Event) {
      final event = message as Event;
      return _buildEventDetail(context, event);
    } else if (message is Task) {
      final task = message as Task;
      return _buildTaskDetail(context, task);
    } else {
      return const Center(child: Text("Unknown message type"));
    }
  }

  Widget _buildMemoDetail(BuildContext context, Memo memo) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: isLandscape
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Icon(CupertinoIcons.back, size: 28),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "Inbox",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                ],
              ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(CupertinoIcons.mail, size: 28),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "From: ${memo.author}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Sent: ${_formatDate(memo.createdAt)}"),
                        const Text("To: You"),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              // Body
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    memo.message,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventDetail(BuildContext context, Event event) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: isLandscape
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Icon(CupertinoIcons.back, size: 28),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "Inbox",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                ],
              ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(CupertinoIcons.calendar, size: 28),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "From: ${event.organizer}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Sent: ${_formatDate(event.createdAt)}"),
                        const Text("To: You"),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "When: ${_formatDate(event.startTime)} - ${_formatDate(event.endTime)}",
                      ),
                      const SizedBox(height: 6),
                      Text("Location: ${event.location}"),
                      const SizedBox(height: 6),
                      Text(
                        "Attendees: ${event.attendees.map((a) => "${a.name} (${a.response})").join(', ')}",
                      ),
                      const SizedBox(height: 16),
                      Text(event.description),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CupertinoButton.filled(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    child: const Text("Accept"),
                    onPressed: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                          title: const Text("Accepted"),
                          content: const Text("You have accepted this event."),
                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: const Text("OK"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  CupertinoButton(
                    child: const Text("Decline"),
                    onPressed: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                          title: const Text("Declined"),
                          content: const Text("You have declined this event."),
                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: const Text("OK"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskDetail(BuildContext context, Task task) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: isLandscape
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Icon(CupertinoIcons.back, size: 28),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "Inbox",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                ],
              ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(CupertinoIcons.checkmark_rectangle, size: 28),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Assigned to: ${task.assignedTo}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Sent: ${_formatDate(task.createdAt)}"),
                        const Text("To: You"),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text("Status: ${task.status}"),
                      const SizedBox(height: 6),
                      Text("Priority: ${task.priority}"),
                      const SizedBox(height: 6),
                      Text("Length: ${task.estimateHours} hours"),
                      const SizedBox(height: 6),
                      Text("Due: ${_formatDate(task.dueDate)}"),
                      const SizedBox(height: 16),
                      Text(task.description),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CupertinoButton.filled(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    child: const Text("Mark Complete"),
                    onPressed: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                          title: const Text("Completed"),
                          content: const Text(
                            "You marked this task as complete.",
                          ),
                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: const Text("OK"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  CupertinoButton(
                    child: const Text("Add to To-Do"),
                    onPressed: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                          title: const Text("Added"),
                          content: const Text("Task added to your To-Do list."),
                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: const Text("OK"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
