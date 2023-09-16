import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_django/data/models/note_model.dart';
import 'package:flutter_django/data/repos/notes_repo.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NotesRepo _notesRepo = NotesRepo();
  NoteBloc() : super(NoteInitial()) {
    on<NotesStartedEvent>(_notesStartedEvent);
    on<AddNoteEvent>(_addNoteEvent);
    on<UpdateNoteEvent>(_updateNoteEvent);
    on<DeleteNoteEvent>(_deleteNoteEvent);
  }

  Future<List<NoteModel>> notesList() async {
    List<NoteModel> notes = await _notesRepo.getNotes();
    return notes;
  }

  FutureOr<void> _notesStartedEvent(
    NotesStartedEvent event,
    Emitter<NoteState> emit,
  ) async {
    try {
      List<NoteModel> notes = await notesList();
      emit(NotesLoaded(notes: notes));
    } catch (e) {
      print('$e WHILE GETTING ALL NOTES');
      emit(NotesErrorState(error: e));
    }
  }

  FutureOr<void> _addNoteEvent(
    AddNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    try {
      final bool result = await _notesRepo.createNote(body: event.body);

      if (result) {
        emit(NoteAddedActionState());
        // emit(NotesLoaded(notes: await notesList()));
      } else {
        emit(NotesErrorState(error: Exception('ERROR WHILE ADDING NOTE')));
      }
    } catch (e) {
      print(e);
      emit(NotesErrorState(error: e));
    }
  }

  FutureOr<void> _updateNoteEvent(
    UpdateNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    try {
      final bool result = await _notesRepo.updateNote(
        id: event.note.id!,
        body: event.note.body,
      );
      if (result) {
        emit(NoteUpdatedActionState());
        emit(NotesLoaded(notes: await notesList()));
      } else {
        emit(NotesErrorState(error: Exception('SEE ME (WHEN UPDATING)')));
      }
    } catch (e) {
      print('$e WHILE UPDATING NOTE');
      emit(NotesErrorState(error: e));
    }
  }

  FutureOr<void> _deleteNoteEvent(
    DeleteNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    try {
      final bool result = await _notesRepo.deleteNote(id: event.id);
      if (result) {
        emit(NoteDeletedActionState());
        emit(NotesLoaded(notes: await notesList()));
      } else {
        emit(NotesErrorState(error: Exception('SEE ME (WHEN DELETING)')));
      }
    } catch (e) {
      print('$e WHILE DELETING NOTE');
      emit(NotesErrorState(error: e));
    }
  }
}
