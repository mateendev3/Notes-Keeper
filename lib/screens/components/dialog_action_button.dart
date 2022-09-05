import 'package:flutter/material.dart';

Widget buildDialogActionButton(String text, VoidCallback onTap) {
  return ElevatedButton(
    onPressed: onTap,
    child: Text(text),
  );
}
