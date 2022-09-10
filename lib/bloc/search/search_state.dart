import '../../models/note.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingListState extends SearchState {}

class SearchLoadedListState extends SearchState {
  SearchLoadedListState(this.notes);

  List<Note> notes;
}

class SearchGetNotesWithTextState extends SearchState {
  SearchGetNotesWithTextState(this.filteredNotes);

  List<Note> filteredNotes;
}

class SearchErrorState extends SearchState {
  SearchErrorState(this.message);

  String message;
}
