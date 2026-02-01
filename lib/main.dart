import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/data/notes_repository.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/viewmodels/notes_viewmodels.dart';
import 'screens/notes_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  final box = await Hive.openBox<Note>('notes');

  final repository = NotesRepository(box);
  final viewModel = NotesViewModel(repository);

  runApp( MyApp(viewModel: viewModel,));
}

class MyApp extends StatelessWidget {
  final NotesViewModel viewModel;

  const MyApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotesListScreen(viewModel: viewModel,),
    );
  }
}
