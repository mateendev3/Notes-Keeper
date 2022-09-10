import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/note.dart';
import '../../repository/notes_repository.dart';
import '../notes_bloc_imports.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository _notesRepository = NotesRepository();
  NotesBloc() : super(NotesInitialState()) {
    on<GetAllNotesEvent>((event, emit) async {
      emit.call(NotesLoadingState());
      try {
        List<Note> notes = await _notesRepository.getAllNotes();
        emit.call(NotesLoadedState(notes));
      } catch (e) {
        emit.call(NotesErrorState(e.toString()));
      }
    });

    on<DeleteAllNotesEvent>((event, emit) {
      _notesRepository.deleteAllNotes();
      emit.call(AllNotesDeletedState());
    });

    on<ShowNotesInGridEvent>((event, emit) {
      emit.call(ShowNotesInViewState(true));
    });

    on<ShowNotesInListEvent>((event, emit) {
      emit.call(ShowNotesInViewState(false));
    });

    on<CreateNoteEvent>((event, emit) async {
      await _notesRepository.createNote(event.note);
      List<Note> notes = await _notesRepository.getAllNotes();
      emit.call(CreateNoteState(notes));
    });

    on<DeleteNoteEvent>((event, emit) async {
      await _notesRepository.deleteNoteById(event.id);
      List<Note> notes = await _notesRepository.getAllNotes();
      emit.call(DeleteNoteState(notes));
    });

    on<UpdateNoteEvent>((event, emit) async {
      await _notesRepository.updateNoteById(event.note);
      List<Note> notes = await _notesRepository.getAllNotes();
      emit.call(UpdateNoteState(notes));
    });

    on<CloseDBEvent>((event, emit) async {
      await _notesRepository.closeDB();
    });
  }
}
