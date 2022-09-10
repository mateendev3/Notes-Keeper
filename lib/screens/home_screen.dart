// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../bloc/notes_bloc_imports.dart';
import '../models/note.dart';
import '../utils/assets_constants.dart';
import '../utils/color_constants.dart';
import 'components/action_icon_widget.dart';
import 'add_update_note_screen.dart';
import 'components/delete_note_alert_dialog_widget.dart';
import 'components/delete_notes_alert_dialog_widget.dart';
import 'components/dismissible_background.dart';
import 'components/empty_notes_ui_widget.dart';
import 'components/listing_icon_widget.dart';
import 'components/notes_grid_item_widget.dart';
import 'components/notes_list_item_widget.dart';
import 'search_note_screen.dart';
import 'watch_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Size _size;
  bool _showGrid = true;
  late List<Note> _noteList;
  bool _wannaDeleteListItem = false;

  @override
  void dispose() {
    closeDB();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildAddNoteFAB(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('NotesKeeper'),
      actions: [
        buildActionIcon(
          iconPath: AssetsConsts.icDustbin,
          onTap: () async {
            bool agree = await showDeleteAllNotesDialog(context);
            if (agree) {
              context.read<NotesBloc>().add(DeleteAllNotesEvent());
            }
          },
          rightMargin: 8.0,
        ),
        buildActionIcon(
          iconPath: AssetsConsts.icSearch,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SearchNoteScreen(),
              ),
            );
          },
          rightMargin: 10.0,
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.only(
        left: _size.height * 0.015,
        right: _size.height * 0.015,
        bottom: _size.height * 0.015,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: _size.height * 0.015,
              right: _size.height * 0.015,
              bottom: _size.height * 0.015,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: _size.height * 0.01,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.white,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Text(
                        'All Notes',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: AppColors.lightGray,
                            ),
                      ),
                    ),
                  ),
                ),
                buildListingIcon(
                  AssetsConsts.icGrid,
                  () {
                    if (_showGrid) {
                      return;
                    } else {
                      context.read<NotesBloc>().add(ShowNotesInGridEvent());
                    }
                  },
                ),
                buildListingIcon(
                  AssetsConsts.icList,
                  () {
                    if (!_showGrid) {
                      return;
                    } else {
                      context.read<NotesBloc>().add(ShowNotesInListEvent());
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<NotesBloc, NotesState>(
              builder: (context, state) {
                if (state is NotesLoadingState || state is NotesInitialState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  );
                } else if (state is NotesLoadedState) {
                  _noteList = state.notes;
                  return _buildListOrEmpty();
                } else if (state is AllNotesDeletedState) {
                  _noteList = [];
                  return _buildListOrEmpty();
                } else if (state is ShowNotesInViewState) {
                  _showGrid = state.inGrid;
                  return _buildListOrEmpty();
                } else if (state is DeleteNoteState) {
                  _noteList = state.notes;
                  return _buildListOrEmpty();
                } else if (state is CreateNoteState) {
                  _noteList = state.notes;
                  return _buildListOrEmpty();
                } else if (state is UpdateNoteState) {
                  _noteList = state.notes;
                  return _buildListOrEmpty();
                } else if (state is NotesErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNoteFAB() {
    return TweenAnimationBuilder<Offset>(
      duration: const Duration(seconds: 2),
      tween: Tween<Offset>(
        begin: const Offset(0, -800),
        end: const Offset(0, 0),
      ),
      curve: Curves.bounceOut,
      builder: (context, Offset offset, child) {
        return Transform.translate(
          offset: offset,
          child: child,
        );
      },
      child: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddUpdateNoteScreen(),
            ),
          );
        },
        backgroundColor: AppColors.white,
        child: Icon(
          Icons.add,
          color: AppColors.codGray,
          size: _size.width * 0.08,
        ),
      ),
    );
  }

  Widget _buildListOrEmpty() {
    if (_noteList.isEmpty) {
      return buildEmptyNotesUi(_size, path: AssetsConsts.svgEmptyNotes);
    } else {
      return _showGrid ? _buildNotesGridView() : _buildNotesListView();
    }
  }

  Widget _buildNotesGridView() {
    return AnimationLimiter(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: _size.height * 0.01,
          crossAxisSpacing: _size.height * 0.01,
        ),
        itemCount: _noteList.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 2,
            duration: const Duration(milliseconds: 500),
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: NotesGridItem(
                  note: _noteList[index],
                  onGridItemTap: onNoteItemTap(index),
                  onGridItemLongPress: onNoteItemLongPress(index),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotesListView() {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: _noteList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ObjectKey(_noteList[index]),
            direction: DismissDirection.startToEnd,
            confirmDismiss: deleteNoteConfirmDismiss(index),
            background: buildDismissibleBackground(
              size: _size,
              color: Colors.red,
              icon: Icons.delete,
              title: 'Delete',
            ),
            child: AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50,
                child: FadeInAnimation(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: _size.width * 0.01),
                    child: SizedBox(
                      width: double.infinity,
                      child: NotesListItem(
                        size: _size,
                        note: _noteList[index],
                        onTap: onNoteItemTap(index),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void closeDB() => context.read<NotesBloc>().add(CloseDBEvent());

  VoidCallback onNoteItemTap(int index) {
    return () async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WatchNoteScreen(
            note: _noteList[index],
          ),
        ),
      );
    };
  }

  VoidCallback onNoteItemLongPress(int index) {
    return () async {
      bool wannaDeleteGridItem = await showDeleteNoteDialog(context);

      if (wannaDeleteGridItem) {
        context.read<NotesBloc>().add(DeleteNoteEvent(_noteList[index].id!));
        wannaDeleteGridItem = false;
      }
    };
  }

  ConfirmDismissCallback deleteNoteConfirmDismiss(int index) {
    return (direction) async {
      _wannaDeleteListItem = await showDeleteNoteDialog(context);

      if (_wannaDeleteListItem) {
        context.read<NotesBloc>().add(DeleteNoteEvent(_noteList[index].id!));
        _wannaDeleteListItem = false;

        return true;
      }

      return false;
    };
  }
}
