import 'package:flutter/material.dart';
import 'package:notes_keeper/utils/color_constants.dart';
import 'components/action_icon_widget.dart';

class SearchNoteScreen extends StatefulWidget {
  const SearchNoteScreen({Key? key}) : super(key: key);

  @override
  State<SearchNoteScreen> createState() => _SearchNoteScreenState();
}

class _SearchNoteScreenState extends State<SearchNoteScreen> {
  late Size _size;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_textChangedListener);
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          top: _size.height * 0.02,
          left: _size.height * 0.035,
          right: _size.height * 0.035,
        ),
        child: _buildBody(),
      ),
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
    return Column(
      children: [
        _buildSearchNoteTF(),
        const Expanded(
          child: SizedBox(),
        ),
      ],
    );
  }

  TextField _buildSearchNoteTF() {
    return TextField(
      controller: _searchController,
      cursorColor: AppColors.orange,
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

  void _textChangedListener() {
    setState(() {});
  }
}
