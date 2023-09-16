// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_django/bloc/note_bloc.dart';
import 'package:flutter_django/views/add_note.dart';
import 'package:flutter_django/views/update_note.dart';

class Notes extends StatefulWidget {
  const Notes({
    Key? key,
  }) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final NoteBloc noteBloc = NoteBloc();

  @override
  void initState() {
    noteBloc.add(NotesStartedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            noteBloc.add(NotesStartedEvent());
          },
          icon: const Icon(Icons.refresh),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Notes Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNote(
                    noteBloc: noteBloc,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<NoteBloc, NoteState>(
        bloc: noteBloc,
        listenWhen: (previous, current) => current is NoteActionState,
        buildWhen: (previous, current) => current is! NoteActionState,
        listener: (context, state) {
          if (state is NoteAddedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(milliseconds: 500),
                backgroundColor: Colors.deepPurpleAccent,
                content: Text('Note Added')));
          }

          if (state is NoteDeletedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 500),
                backgroundColor: Colors.deepPurpleAccent,
                content: Center(child: Text('Note deleted')),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is NoteInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NotesLoaded) {
            final notes = state.notes;
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return UpdateNote(
                            // noteBloc: noteBloc,
                            id: state.notes[index].id!,
                            body: notes[index].body,
                          );
                        },
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.deepPurpleAccent,
                    child: ListTile(
                      title: Text(
                        notes[index].body,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          noteBloc.add(DeleteNoteEvent(
                            id: notes[index].id!,
                          ));
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(state.toString()),
            );
          }
        },
      ),
    );
  }
}
