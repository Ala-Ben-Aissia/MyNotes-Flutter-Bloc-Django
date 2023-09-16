import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_django/bloc/note_bloc.dart';
import 'package:flutter_django/views/notes.dart';

class AddNote extends StatelessWidget {
  const AddNote({super.key, required this.noteBloc});
  final NoteBloc noteBloc;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: BlocListener<NoteBloc, NoteState>(
        bloc: noteBloc,
        listener: (context, state) {
          if (state is NoteAddedActionState) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return const Notes();
              },
            ), (route) => false);
          }
        },
        child: Column(
          children: [
            TextField(
              controller: controller,
            ),
            TextButton(
              onPressed: () {
                noteBloc.add(AddNoteEvent(body: controller.text));
                controller.clear();
                // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                //   builder: (context) {
                //     return const Notes();
                //   },
                // ), (route) => false);
              },
              child: const Text(
                'Add Note',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
