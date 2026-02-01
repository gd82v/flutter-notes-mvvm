import 'package:flutter/material.dart';
import 'package:notes_app/viewmodels/notes_viewmodels.dart';
import '../models/note.dart';

class EditNoteScreen extends StatefulWidget {
  final NotesViewModel viewModel;
  final Note? note;

  const EditNoteScreen({
    super.key,
    required this.viewModel,
    this.note
});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  void _onViewModelChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onViewModelChanged);
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.note == null ? 'New note' : 'Edit note'),
      actions: [IconButton(onPressed: _saveNote, icon: const Icon(Icons.save))],),
      body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),),
              const SizedBox(height: 16,),
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 5,
              )
            ],
          ),)])
    );
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (widget.note == null) {
      widget.viewModel.addNote(
        Note(title: title, content: content),
      );
    } else {
      widget.viewModel.updateNote(widget.note!, title, content);
    }

      Navigator.pop(context);
  }
}