import 'package:flutter/material.dart';

Widget buildListingIcon(String path, VoidCallback onPressed) {
  return IconButton(
    onPressed: onPressed,
    icon: Image.asset(
      path,
      width: 16,
      height: 16,
    ),
    padding: EdgeInsets.zero,
    splashRadius: 30.0,
  );
}
