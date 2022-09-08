import 'package:flutter/material.dart';
import '../../utils/helper_widgets.dart';

Widget buildDismissibleBackground({
  required Size size,
  required Color color,
  required IconData icon,
  required String title,
}) =>
    Container(
      color: color,
      margin: EdgeInsets.all(size.height * 0.0080),
      padding: EdgeInsets.all(size.height * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          addHorizontalSpace(size.width * 0.008),
          Text(title),
        ],
      ),
    );
