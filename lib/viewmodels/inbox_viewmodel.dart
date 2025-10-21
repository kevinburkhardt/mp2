import 'package:flutter/foundation.dart';
import '../models/event.dart';
import '../models/memo.dart';
import '../models/task.dart';
import '../services/json_parser.dart';

class InboxViewmodel extends ChangeNotifier {
  final _parser = JsonParser();

  List<dynamic> _allMessages = [];
  bool _isLoading = false;
  dynamic selectedMessage;

  List<dynamic> get allMessages => _allMessages;
  bool get isLoading => _isLoading;

  Future<void> loadInbox() async {
    _isLoading = true;
    notifyListeners();

    final data = await _parser.loadData();
    final memos = await _parser.loadMemos(data);
    final events = await _parser.loadEvents(data);
    final tasks = await _parser.loadTasks(data);

    // Combine and sort chronologically by createdAt
    _allMessages = [...memos, ...events, ...tasks];
    _allMessages.sort((a, b) {
      DateTime aDate;
      DateTime bDate;

      if (a is Memo) aDate = a.createdAt;
      else if (a is Event) aDate = a.createdAt;
      else if (a is Task) aDate = a.createdAt;
      else aDate = DateTime.now();

      if (b is Memo) bDate = b.createdAt;
      else if (b is Event) bDate = b.createdAt;
      else if (b is Task) bDate = b.createdAt;
      else bDate = DateTime.now();

      return bDate.compareTo(aDate); // earliest first
    });

    _isLoading = false;
    notifyListeners();
  }

  void selectMessage(dynamic message) {
    selectedMessage = message;
    notifyListeners();
  }
}