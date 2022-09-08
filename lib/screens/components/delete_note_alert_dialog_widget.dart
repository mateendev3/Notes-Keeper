import 'package:flutter/material.dart';
import '../../utils/color_constants.dart';
import 'dialog_action_button.dart';

Future<bool> showDeleteNoteDialog(BuildContext context) async {
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
          buildDialogActionButton(
            'No',
            () => Navigator.pop(context, false),
          ),
          buildDialogActionButton(
            'Yes',
            () => Navigator.pop(context, true),
          ),
        ],
      );
    },
  );
}
