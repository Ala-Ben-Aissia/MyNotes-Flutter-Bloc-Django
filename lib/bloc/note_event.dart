part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

class NotesStartedEvent extends NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final String body;

  AddNoteEvent({required this.body});
}

class UpdateNoteEvent extends NoteEvent {
  final NoteModel note;

  UpdateNoteEvent({required this.note});
}

class DeleteNoteEvent extends NoteEvent {
  final int id;

  DeleteNoteEvent({required this.id});
}
