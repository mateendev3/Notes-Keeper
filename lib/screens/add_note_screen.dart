import 'package:flutter/material.dart';

import '../utils/color_constants.dart';
import 'components/action_button_widget.dart';
import 'components/action_icon_widget.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          left: _size.height * 0.015,
          right: _size.height * 0.015,
          bottom: _size.height * 0.015,
        ),
        child: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: buildActionIcon(
        icon: Icons.arrow_back,
        onTap: () {
          Navigator.pop(context);
        },
        rightMargin: 0.0,
        leftMargin: 15.0,
      ),
      actions: [
        buildActionButton(context, text: "Save"),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildTitleTextField(),
        Expanded(
          child: _buildNoteTextField(),
        ),
      ],
    );
  }

  TextFormField _buildNoteTextField() {
    return TextFormField(
      selectionControls: MaterialTextSelectionControls(),
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
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

  TextFormField _buildTitleTextField() {
    return TextFormField(
      selectionControls: MaterialTextSelectionControls(),
      maxLength: 100,
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
