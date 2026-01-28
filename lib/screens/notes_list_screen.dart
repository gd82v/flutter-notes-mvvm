import 'package:flutter/material.dart';
import 'package:notes_app/screens/edit_list_screen.dart';
import 'package:notes_app/viewmodels/notes_viewmodels.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  late final NotesViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = NotesViewModel();
    viewModel.addListener(_onViewModelChanged);
  }

  void _onViewModelChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes'),),
      body: viewModel.notes.isEmpty
          ? const Center(child: Text('No notes yet'))
          : ListView.builder(
              itemCount: viewModel.notes.length,
              itemBuilder: (context, index) {
                final note = viewModel.notes[index];
              return ListTile(
                title: Text(note.title),
                onTap: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => EditNoteScreen(viewModel: viewModel,
                  note: note,))
                  );
                },
                subtitle: Text(note.content),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                      viewModel.deleteNote(note.id);
                  },
                ),
              );
              }),
      floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => EditNoteScreen(viewModel: viewModel))
          );
      },
      child: const Icon(Icons.add),
      ),
    );
  }
}