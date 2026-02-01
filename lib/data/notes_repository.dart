import 'package:hive/hive.dart';
import '../models/note.dart';

class NotesRepository {
  final Box<Note> _notesBox;

  NotesRepository(this._notesBox);

  List<Note> getNotes() {2
    return _notesBox.values.toList();
  }

  void addNote(Note note) {
    _notesBox.add(note);
  }

  void updateNote(Note note, String title, String content) {
    note.title = title;
    note.content = content;
    note.save();
  }

  void deleteNote(Note note) {
    note.delete();
  }
}