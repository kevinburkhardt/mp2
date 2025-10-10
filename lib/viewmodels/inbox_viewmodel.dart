import 'package:flutter/foundation.dart';
import '../models/event.dart';
import '../models/memo.dart';
import '../models/task.dart';
import '../services/json_parser.dart';

class InboxViewmodel extends ChangeNotifier{
  final _parser = JsonParser();

  List<Memo> _memos = [];
  List<Event> _events = [];
  List<Task> _tasks = [];
  bool _isLoading = false;
  dynamic selectedMessage;

  List<Memo> get memos => _memos;
  List<Event> get events => _events;
  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  Future<void> loadInbox() async {
    _isLoading = true;
    notifyListeners();
    final data = await _parser.loadData();
    _memos = await _parser.loadMemos(data);
    _events = await _parser.loadEvents(data);
    _tasks = await _parser.loadTasks(data);
    _isLoading = false;
    notifyListeners();
  }

  void selectMessage(dynamic message){
    selectedMessage = message;
    notifyListeners();
  }
}