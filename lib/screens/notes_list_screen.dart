import 'package:flutter/material.dart';
import 'package:notes_app/screens/edit_list_screen.dart';
import 'package:notes_app/viewmodels/notes_viewmodels.dart';

class NotesListScreen extends StatefulWidget {
  final NotesViewModel viewModel;

  const NotesListScreen({super.key, required this.viewModel});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {

  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onViewModelChanged);
    widget.viewModel.loadNotes();
  }

  void _onViewModelChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes'),),
      body: widget.viewModel.notes.isEmpty
          ? const Center(child: Text('No notes yet'))
          : ListView.builder(
              itemCount: widget.viewModel.notes.length,
              itemBuilder: (context, index) {
                final note = widget.viewModel.notes[index];
              return ListTile(
                title: Text(note.title),
                onTap: () async {
                  await Navigator.push(
                    context, MaterialPageRoute(builder: (context) => EditNoteScreen(viewModel: widget.viewModel,
                  note: note,))
                  );
                  widget.viewModel.loadNotes();
                },
                subtitle: Text(note.content),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => widget.viewModel.deleteNote(note),
                ),
              );
              }),
      floatingActionButton: FloatingActionButton(onPressed: () async {
          await Navigator.push(
            context, MaterialPageRoute(builder: (context) => EditNoteScreen(viewModel: widget.viewModel))
          );
          widget.viewModel.loadNotes();
      },
      child: const Icon(Icons.add),
      ),
    );
  }
}