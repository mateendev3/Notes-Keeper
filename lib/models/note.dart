class Note {
  Note({
    this.id,
    this.title,
    this.description,
    this.time,
  });

  int? id;
  String? title;
  String? description;
  DateTime? time;

  Note copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? time,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
    );
  }

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'title': title,
      'description': description,
      'time': time?.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, Object?> map) {
    return Note(
      id: map['_id'] as int,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      time: map['time'] != null ? DateTime.parse(map['time'] as String) : null,
    );
  }

  @override
  String toString() {
    return 'Note(id: $id, title: $title, description: $description, time: $time)';
  }

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ description.hashCode ^ time.hashCode;
  }
}
