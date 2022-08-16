import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/assets_constants.dart';

Widget buildEmptyNotesUi(Size size) {
  return Center(
    child: Opacity(
      opacity: 0.5,
      child: SvgPicture.asset(
        AssetsConsts.svgEmptyNotes,
        width: size.width * 0.7,
        height: size.width * 0.7,
      ),
    ),
  );
}
