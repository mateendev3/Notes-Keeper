import 'package:flutter/material.dart';
import '../../utils/color_constants.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({Key? key, required Size size})
      : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      selectionControls: MaterialTextSelectionControls(),
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        hintText: 'Type Something...',
        hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
              color: AppColors.lightGray,
              fontSize: _size.width * 0.05,
            ),
        contentPadding: EdgeInsets.symmetric(
          vertical: _size.width * 0.02,
          horizontal: _size.width * 0.02,
        ),
        border: InputBorder.none,
      ),
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: _size.width * 0.05,
          ),
    );
  }
}
