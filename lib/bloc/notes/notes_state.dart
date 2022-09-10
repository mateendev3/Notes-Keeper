import '../../models/note.dart';

abstract class NotesState {}

class NotesInitialState extends NotesState {}

class NotesLoadingState extends NotesState {}

class NotesLoadedState extends NotesState {
  NotesLoadedState(this.notes);

  List<Note> notes;
}

class AllNotesDeletedState extends NotesState {}

class CreateNoteState extends NotesState {
  CreateNoteState(this.notes);

  List<Note> notes;
}

class DeleteNoteState extends NotesState {
  DeleteNoteState(this.notes);

  List<Note> notes;
}

class UpdateNoteState extends NotesState {
  UpdateNoteState(this.notes);

  List<Note> notes;
}

class NotesErrorState extends NotesState {
  NotesErrorState(this.message);

  String message;
}

class ShowNotesInViewState extends NotesState {
  ShowNotesInViewState(this.inGrid);

  bool inGrid = true;
}
