import 'package:notes_keeper/models/note.dart';

abstract class NotesEvent {
  NotesEvent({this.notes});

  List<Note>? notes;
}

class GetAllNotesEvent extends NotesEvent {}

class CreateNoteEvent extends NotesEvent {
  CreateNoteEvent(this.note);

  Note note;
}

class DeleteNoteEvent extends NotesEvent {
  DeleteNoteEvent(this.id);

  int id;
}

class UpdateNoteEvent extends NotesEvent {
  UpdateNoteEvent(this.note);

  Note note;
}

class DeleteAllNotesEvent extends NotesEvent {}

class ShowNotesInGridEvent extends NotesEvent {}

class ShowNotesInListEvent extends NotesEvent {}

class CloseDBEvent extends NotesEvent {}
