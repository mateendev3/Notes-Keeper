import '../../models/note.dart';

abstract class SearchEvent {}

class SearchGetAllNotesEvent extends SearchEvent {}

class SearchGetNotesWithTextEvent extends SearchEvent {
  SearchGetNotesWithTextEvent(this.text, this.notesList);

  String text;
  List<Note> notesList;
}
