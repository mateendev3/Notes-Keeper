// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:notes_keeper/databases/db_helper.dart';
import 'package:notes_keeper/models/note.dart';
import 'package:notes_keeper/screens/add_update_note_screen.dart';
import 'package:notes_keeper/utils/assets_constants.dart';
import 'package:notes_keeper/utils/helper_widgets.dart';

import '../utils/color_constants.dart';
import 'components/action_icon_widget.dart';

class WatchNoteScreen extends StatefulWidget {
  const WatchNoteScreen({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  State<WatchNoteScreen> createState() => _WatchNoteScreenState();
}

class _WatchNoteScreenState extends State<WatchNoteScreen> {
  late Size _size;
  late Note _note;
  late DBHelper _db;

  @override
  void initState() {
    _note = widget.note;
    _db = DBHelper();
    super.initState();
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
      leading: buildActionIcon(
        icon: Icons.arrow_back,
        onTap: () {
          Navigator.pop(context);
        },
        rightMargin: 0.0,
        leftMargin: 15.0,
      ),
      actions: [
        buildActionIcon(
          onTap: () async {
            bool agree = await showAlertDialog();
            if (agree) {
              await _db.deleteNote(_note.id!);
              Navigator.pop(context);
            }
          },
          rightMargin: 15.0,
          iconPath: AssetsConsts.icDustbin,
        ),
        buildActionIcon(
          onTap: () async {
            _note = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddUpdateNoteScreen(
                  note: _note,
                ),
              ),
            );
            setState(() {});
          },
          rightMargin: 15.0,
          icon: Icons.edit_outlined,
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildTitleText(),
        addVerticalSpace(_size.height * 0.04),
        Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: _buildNoteText(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleText() {
    return SizedBox(
      width: double.infinity,
      child: Text(
        _note.title ?? '',
        maxLines: null,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: AppColors.white,
              fontSize: _size.width * 0.08,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  _buildNoteText() {
    return Text(
      _note.description ?? '',
      maxLines: null,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: _size.width * 0.05,
          ),
    );
  }

  Future<bool> showAlertDialog() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text(
            'Do you really want to delete the note?',
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
