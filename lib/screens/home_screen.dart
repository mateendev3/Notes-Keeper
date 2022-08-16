import 'package:flutter/material.dart';
import 'package:notes_keeper/databases/db_helper.dart';
import '../models/note.dart';
import '../utils/assets_constants.dart';
import '../utils/color_constants.dart';
import 'components/action_icon_widget.dart';
import 'add_update_note_screen.dart';
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
  bool _isLoading = false;
  late List<Note> _noteList;
  late final DBHelper _db;

  @override
  void initState() {
    _db = DBHelper();
    super.initState();

    refreshNotes();
  }

  // method to refresh notes (get notes from db)
  void refreshNotes() async {
    setState(() => _isLoading = true);

    _noteList = await _db.readAllNotes();

    setState(() => _isLoading = false);
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
            bool agree = await showAlertDialog();
            if (agree) {
              await _db.deleteNotes();
              refreshNotes();
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
                buildListingIcon(AssetsConsts.icGrid, () {
                  if (_showGrid) {
                    return;
                  } else {
                    setState(() => _showGrid = true);
                  }
                }),
                buildListingIcon(AssetsConsts.icList, () {
                  if (!_showGrid) {
                    return;
                  } else {
                    setState(() {
                      _showGrid = false;
                    });
                  }
                }),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  )
                : _buildListOrEmpty(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNoteFAB() {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AddUpdateNoteScreen(),
          ),
        );
        refreshNotes();
      },
      backgroundColor: AppColors.codGray,
      child: Icon(
        Icons.add,
        color: AppColors.white,
        size: _size.width * 0.08,
      ),
    );
  }

  Widget _buildListOrEmpty() {
    if (_noteList.isEmpty) {
      return buildEmptyNotesUi(_size);
    } else {
      return _showGrid ? _buildNotesGridView() : _buildNotesListView();
    }
  }

  Widget _buildNotesGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: _size.height * 0.01,
        crossAxisSpacing: _size.height * 0.01,
      ),
      itemCount: _noteList.length,
      itemBuilder: (context, index) {
        return NotesGridItem(
          note: _noteList[index],
          onTap: onNoteItemTap(index),
        );
      },
    );
  }

  Widget _buildNotesListView() {
    return ListView.builder(
      itemCount: _noteList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: _size.width * 0.01),
          child: NotesListItem(
            size: _size,
            note: _noteList[index],
            onTap: onNoteItemTap(index),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    closeDB();
    super.dispose();
  }

  void closeDB() async => await _db.closeDatabase();

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
      refreshNotes();
    };
  }

  Future<bool> showAlertDialog() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text(
            'Do you really want to delete all the notes?',
            style: TextStyle(
              color: AppColors.white,
            ),
          ),
          actions: [
            _buildActionButton(
              'No',
              () => Navigator.pop(context, false),
            ),
            _buildActionButton(
              'Yes',
              () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }

  Widget _buildActionButton(String text, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(text),
    );
  }
}
