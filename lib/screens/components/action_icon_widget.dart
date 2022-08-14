import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/color_constants.dart';

Widget buildActionIcon({
  String? iconPath,
  IconData? icon,
  required VoidCallback onTap,
  required double rightMargin,
  double leftMargin = 0.0,
}) {
  return Container(
    margin: EdgeInsets.only(
      top: 10.0,
      bottom: 10.0,
      right: rightMargin,
      left: leftMargin,
    ),
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      color: AppColors.darkGray,
      borderRadius: BorderRadius.circular(12),
    ),
    alignment: Alignment.center,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: iconPath != null
              ? SvgPicture.asset(iconPath, width: 20, height: 20)
              : Icon(icon, size: 20),
        ),
      ),
    ),
  );
}
