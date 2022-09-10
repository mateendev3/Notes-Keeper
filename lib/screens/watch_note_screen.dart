// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notes_bloc_imports.dart';
import '../models/note.dart';
import '../utils/assets_constants.dart';
import '../utils/color_constants.dart';
import '../utils/helper_widgets.dart';
import 'add_update_note_screen.dart';
import 'components/action_icon_widget.dart';
import 'components/delete_note_alert_dialog_widget.dart';

class WatchNoteScreen extends StatefulWidget {
  const WatchNoteScreen({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  State<WatchNoteScreen> createState() => _WatchNoteScreenState();
}

class _WatchNoteScreenState extends State<WatchNoteScreen> {
  late Size _size;
  late Note _note;

  @override
  void initState() {
    _note = widget.note;
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
            bool agree = await showDeleteNoteDialog(context);
            if (agree) {
              context.read<NotesBloc>().add(DeleteNoteEvent(_note.id!));
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
}
