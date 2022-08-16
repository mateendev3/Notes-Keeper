import 'package:flutter/material.dart';
import '../../utils/color_constants.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    Key? key,
    required Size size,
    required TextEditingController controller,
  })  : _size = size,
        _titleController = controller,
        super(key: key);

  final Size _size;
  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      selectionControls: MaterialTextSelectionControls(),
      autofocus: true,
      controller: _titleController,
      maxLength: 80,
      maxLines: 2,
      decoration: InputDecoration(
        hintText: 'Title',
        hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
              color: AppColors.lightGray,
              fontSize: _size.width * 0.08,
            ),
        contentPadding: EdgeInsets.symmetric(
          vertical: _size.width * 0.02,
          horizontal: _size.width * 0.02,
        ),
        border: InputBorder.none,
      ),
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: AppColors.white,
            fontSize: _size.width * 0.08,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}
