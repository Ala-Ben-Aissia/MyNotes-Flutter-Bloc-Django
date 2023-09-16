class NoteModel {
  final int? id;
  final String body;
  final String created;
  final String updated;

  NoteModel({
    this.id,
    required this.body,
    this.created = 'DEFAULT CREATED',
    this.updated = ' DEFAULT UPDATED',
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as int,
      body: map['body'] as String,
      created: map['created'] as String,
      updated: map['updated'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'body': body,
      'created': created,
      'updated': updated,
    };
  }

  @override
  String toString() {
    return 'NoteModel(id: $id, body: $body, created: $created, updated: $updated)';
  }
}
