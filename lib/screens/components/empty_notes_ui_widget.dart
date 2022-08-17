import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildEmptyNotesUi(Size size, {required String path}) {
  return Center(
    child: Opacity(
      opacity: 0.5,
      child: SvgPicture.asset(
        path,
        width: size.width * 0.7,
        height: size.width * 0.7,
      ),
    ),
  );
}
