import 'package:flutter_django/data/models/note_model.dart';
import 'package:flutter_django/data/providers/notes_providers.dart';

class NotesRepo {
  final NotesAPI notesAPI = NotesAPI();
  Future<List<NoteModel>> getNotes() async {
    List<dynamic> notes0 = await notesAPI.getAllNotes();
    List<NoteModel> notes = notes0
        .map(
          (note) => NoteModel.fromMap(note),
        )
        .toList();
    return notes;
  }

  Future<NoteModel> getNote(int id) async {
    Map<String, dynamic> note = await notesAPI.getNote(id: id);
    return NoteModel.fromMap(note);
  }

  Future<bool> createNote({required String body}) async {
    if (body.isNotEmpty) {
      final int code = await notesAPI.createNote(body: body);
      if (code == 200) {
        print('NOTE CREATED SUCCESSFULLY');
        return true;
      } else {
        print('STATUS CODE IS $code');
        return false;
      }
    } else {
      print('NOTE BODY SHOULD NOT BE EMPTY');
      return false;
    }
  }

  Future<bool> updateNote({required int id, required String body}) async {
    if (body.isNotEmpty) {
      final int code = await notesAPI.updateNote(id: id, body: body);
      if (code == 200) {
        print('NOTE UPDATED SUCCESSFULLY');
        return true;
      } else {
        print('STATUS CODE IS $code');
        return false;
      }
    } else {
      print('NOTE BODY SHOULD NOT BE EMPTY');
      return false;
    }
  }

  Future<bool> deleteNote({required int id}) async {
    final int code = await notesAPI.deleteNote(id: id);
    if (code == 200) {
      print('NOTE DELETED SUCCESSFULLY');
      return true;
    } else {
      print('STATUS CODE IS $code');
      return false;
    }
  }
}
