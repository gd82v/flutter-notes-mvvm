import 'package:flutter/foundation.dart';
import '../models/note.dart';

class NotesViewModel extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => List.unmodifiable(_notes);

  void addNote(String title, String content) {
    _notes.add(
      Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        content: content,
        createdAt: DateTime.now()
      )
    );
    notifyListeners();
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void updateNote(String id, String newTitle, String newContent) {
    final note = _notes.firstWhere((note) => note.id == id);
    note.title = newTitle;
    note.content = newContent;
    notifyListeners();
  }
}