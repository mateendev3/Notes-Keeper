// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notes_bloc_imports.dart';
import '../models/note.dart';
import 'components/action_button_widget.dart';
import 'components/action_icon_widget.dart';
import 'components/description_text_field_widget.dart';
import 'components/title_text_field_widget.dart';

class AddUpdateNoteScreen extends StatefulWidget {
  const AddUpdateNoteScreen({Key? key, this.note}) : super(key: key);

  final Note? note;

  @override
  State<AddUpdateNoteScreen> createState() => _AddUpdateNoteScreenState();
}

class _AddUpdateNoteScreenState extends State<AddUpdateNoteScreen> {
  late Size _size;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late Note _note;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _titleController.text = widget.note?.title ?? '';
    _descriptionController.text = widget.note?.description ?? '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: buildActionIcon(
        icon: Icons.arrow_back,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          Navigator.pop(context);
        },
        rightMargin: 0.0,
        leftMargin: 15.0,
      ),
      actions: [
        buildActionButton(context, text: "Save", onTap: onTapSave),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: _size.height * 0.015,
        right: _size.height * 0.015,
        bottom: _size.height * 0.015,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TitleTextField(
              size: _size,
              controller: _titleController,
            ),
            Expanded(
              child: DescriptionTextField(
                size: _size,
                controller: _descriptionController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapSave() {
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      if (widget.note != null) {
        updateNote();
        Navigator.pop(context, _note);
      } else {
        insertNote(context);
        Navigator.pop(context);
      }
    }
  }

  void updateNote() {
    _note = widget.note!.copyWith(
      title: _titleController.text,
      description: _descriptionController.text,
    );
    context.read<NotesBloc>().add(UpdateNoteEvent(_note));
  }

  void insertNote(BuildContext context) {
    context.read<NotesBloc>().add(
          CreateNoteEvent(
            Note(
              title: _titleController.text,
              description: _descriptionController.text,
              time: DateTime.now(),
            ),
          ),
        );
  }
}
