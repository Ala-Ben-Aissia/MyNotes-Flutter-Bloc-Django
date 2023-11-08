// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_django/bloc/note_bloc.dart';
import 'package:flutter_django/data/models/note_model.dart';
import 'package:flutter_django/views/notes.dart';

class UpdateNote extends StatefulWidget {
  const UpdateNote({
    Key? key,
    required this.body,
    required this.id,
  }) : super(key: key);
  final String body;
  final int id;

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

final TextEditingController controller = TextEditingController();

class _UpdateNoteState extends State<UpdateNote> {
  @override
  void initState() {
    controller.text = widget.body;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Note'),
      ),
      body: BlocListener<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state is NoteUpdatedActionState) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return const Notes();
              },
            ), (route) => false);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(milliseconds: 500),
                backgroundColor: Colors.deepPurpleAccent,
                content: Center(child: Text('Note Updated'))));
          }
        },
        child: Column(
          children: [
            TextField(
              controller: controller,
            ),
            TextButton(
              onPressed: () {
                context.read<NoteBloc>().add(
                      UpdateNoteEvent(
                        note: NoteModel(
                          id: widget.id,
                          body: controller.text,
                        ),
                      ),
                    );
              },
              child: const Text('Update Note'),
            )
          ],
        ),
      ),
    );
  }
}
