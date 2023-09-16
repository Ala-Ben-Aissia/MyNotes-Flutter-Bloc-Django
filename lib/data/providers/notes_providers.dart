import 'dart:convert';

import 'package:flutter_django/utilities/urls.dart';
import 'package:http/http.dart';

class NotesAPI {
  Future<List> getAllNotes() async {
    Response response = await get(Uri.parse(AppUrls.allNotes));
    List<dynamic> notes = jsonDecode(response.body);
    return notes;
  }

  Future<Map<String, dynamic>> getNote({required int id}) async {
    Response response = await get(Uri.parse('${AppUrls.allNotes}$id/'));
    Map<String, dynamic> note = jsonDecode(response.body);
    return note;
  }

  Future<int> createNote({required String body}) async {
    Response response = await post(Uri.parse(AppUrls.createNote), body: {
      'body': body,
    });
    return response.statusCode;
  }

  Future<int> updateNote({required int id, required String body}) async {
    Response response =
        await put(Uri.parse('${AppUrls.allNotes}$id/update/'), body: {
      'body': body,
    });
    return response.statusCode;
  }

  Future<int> deleteNote({required int id}) async {
    Response response =
        await delete(Uri.parse('${AppUrls.allNotes}$id/delete/'));
    return response.statusCode;
  }
}
