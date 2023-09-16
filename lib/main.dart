import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_django/bloc/note_bloc.dart';
import 'package:flutter_django/views/notes.dart';

void main() async {
  runApp(
    BlocProvider(
      create: (context) => NoteBloc()..add(NotesStartedEvent()),
      child: const MaterialApp(
        home: Notes(),
      ),
    ),
  );
}
