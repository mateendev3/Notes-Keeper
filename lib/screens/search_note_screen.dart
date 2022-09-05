import 'package:flutter/material.dart';
import 'package:notes_keeper/databases/db_helper.dart';
import 'package:notes_keeper/utils/color_constants.dart';
import '../models/note.dart';
import '../utils/assets_constants.dart';
import 'components/action_icon_widget.dart';
import 'components/empty_notes_ui_widget.dart';
import 'components/notes_list_item_widget.dart';
import 'watch_note_screen.dart';

class SearchNoteScreen extends StatefulWidget {
  const SearchNoteScreen({Key? key}) : super(key: key);

  @override
  State<SearchNoteScreen> createState() => _SearchNoteScreenState();
}

class _SearchNoteScreenState extends State<SearchNoteScreen> {
  late Size _size;
  late final TextEditingController _searchController;
  late List<Note> _noteList;
  late List<Note> _filteredList;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
    _searchController = TextEditingController();
  }

  void refreshNotes() async {
    setState(() => _isLoading = true);

    _noteList = await DBHelper().readAllNotes();
    _filteredList = _noteList;

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Search Note'),
      centerTitle: true,
      leading: buildActionIcon(
        icon: Icons.arrow_back,
        onTap: () {
          Navigator.pop(context);
        },
        rightMargin: 0.0,
        leftMargin: 15.0,
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.only(
        top: _size.height * 0.02,
        left: _size.height * 0.035,
        right: _size.height * 0.035,
      ),
      child: Column(
        children: [
          _buildSearchNoteTF(),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  )
                : _buildBodyUi(),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyUi() {
    return _filteredList.isNotEmpty
        ? _buildNotesListView()
        : buildEmptyNotesUi(
            _size,
            path: AssetsConsts.svgNotFound,
          );
  }

  TextField _buildSearchNoteTF() {
    return TextField(
      controller: _searchController,
      cursorColor: AppColors.orange,
      autofocus: true,
      onChanged: _onChangedText,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: _size.width * 0.04,
          ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.darkGray,
        enabled: true,
        suffixIcon: _searchController.text.isEmpty
            ? const Icon(
                Icons.search,
                color: AppColors.white,
              )
            : IconButton(
                onPressed: () {
                  _searchController.clear();
                  refreshNotes();
                },
                icon: const Icon(
                  Icons.cancel,
                  color: AppColors.white,
                ),
              ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        hintText: 'Search by the keyword...',
        hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: AppColors.lightGray,
              fontSize: _size.width * 0.04,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    );
  }

  Widget _buildNotesListView() {
    return Padding(
      padding: EdgeInsets.only(top: _size.width * 0.07),
      child: ListView.builder(
        itemCount: _filteredList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: _size.width * 0.01),
            child: NotesListItem(
              size: _size,
              note: _filteredList[index],
              onTap: onNoteItemTap(index),
            ),
          );
        },
      ),
    );
  }

  VoidCallback onNoteItemTap(int index) {
    return () async {
      _searchController.clear();
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WatchNoteScreen(
            note: _filteredList[index],
          ),
        ),
      );
      refreshNotes();
    };
  }

  void _onChangedText(String value) {
    _filteredList = _noteList
        .where(
            (note) => note.title!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }
}
