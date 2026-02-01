import 'package:flutter/foundation.dart';
import '../data/notes_repository.dart';
import '../models/note.dart';

class NotesViewModel extends ChangeNotifier {
  final NotesRepository _repository;

  NotesViewModel(this._repository);

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  void loadNotes() {
    _notes = _repository.getNotes();
    notifyListeners();
  }

  void addNote(Note note) {
    _repository.addNote(note);
    loadNotes();
  }

  void deleteNote(note) {
    _repository.deleteNote(note);
    loadNotes();
  }

  void updateNote(Note note, String newTitle, String newContent) {
    _repository.updateNote(note, newTitle, newContent);
    loadNotes();
  }
}