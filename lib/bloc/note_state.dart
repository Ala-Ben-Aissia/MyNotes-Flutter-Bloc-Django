part of 'note_bloc.dart';

@immutable
abstract class NoteState extends Equatable {}

class NoteInitial extends NoteState {
  @override
  List<Object?> get props => [];
}

class NotesLoaded extends NoteState {
  final List<NoteModel> notes;

  NotesLoaded({required this.notes});

  @override
  List<Object?> get props => [notes];
}

class NotesErrorState extends NoteState {
  final Object error;

  NotesErrorState({required this.error});

  @override
  List<Object?> get props => [];
}

abstract class NoteActionState extends NoteState {}

class NoteAddedActionState extends NoteActionState {
  @override
  List<Object?> get props => [];
}

class NoteUpdatedActionState extends NoteActionState {
  @override
  List<Object?> get props => [];
}

class NoteDeletedActionState extends NoteActionState {
  @override
  List<Object?> get props => [];
}
