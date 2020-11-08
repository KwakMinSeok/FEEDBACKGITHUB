import 'package:firebase1102/src/models/entry.dart';
import 'package:firebase1102/src/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:date_format/date_format.dart';

class EntryProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  var uuid = Uuid();
  DateTime _dateTime;
  String _entry, _entryId;
  //getter
  DateTime get getdate => _dateTime;
  String get getentry => _entry;
  Stream<List<Entry>> get getentries => firestoreService.getEntries();
  //setter
  set changeDate(DateTime dateTime) {
    _dateTime = dateTime;
    notifyListeners();
  }

  set changeEntry(String entry) {
    _entry = entry;
    notifyListeners();
  }
/*
  changeorder(List<Entry> entrylist) {
    final format = DateTime.parse('yyyy-M-d H:m:s:S');

    entrylist.map((e) => format).toList()..sort(
      (a,b)=>a.date
    );
    notifyListeners();
  }*/

  //functions
  loadAll(Entry entry) {
    if (entry != null) {
      _dateTime = DateTime.parse(entry.date);
      _entry = entry.entry;
      _entryId = entry.entryId;
    } else {
      _dateTime = DateTime.now();
      _entry = null;
      _entryId = null;
    }
  }

  saveEntry() {
    if (_entryId == null) {
      var newEntry = Entry(
          date: _dateTime.toIso8601String(), entry: _entry, entryId: uuid.v1());
      firestoreService.setEntry(newEntry);
    } else {
      var updatedEntry = Entry(
          date: _dateTime.toIso8601String(), entry: _entry, entryId: uuid.v1());
      firestoreService.setEntry(updatedEntry);
    }
  }

  removeEntry(String entryId) {
    firestoreService.removeEntry(entryId);
  }
}
