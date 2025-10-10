import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

import '../models/event.dart';
import '../models/memo.dart';
import '../models/task.dart';

class JsonParser {
  Future<List<Memo>> loadMemos(Map<String, dynamic>? data) async {
    data ??= await loadData();
    return (data['memos'] as List)
        .map((json) => Memo.fromJson(json))
        .toList();
  }

  Future<List<Event>> loadEvents(Map<String, dynamic>? data) async {
    data ??= await loadData();
    return (data['events'] as List)
        .map((json) => Event.fromJson(json))
        .toList();
  }

  Future<List<Task>> loadTasks(Map<String, dynamic>? data) async {
    data ??= await loadData();
    return (data['tasks'] as List)
        .map((json) => Task.fromJson(json))
        .toList();
  }

  Future<Map<String, dynamic>> loadData() async {
    final content = await rootBundle.loadString('assets/mp2.json');
    return jsonDecode(content);
  }
}
