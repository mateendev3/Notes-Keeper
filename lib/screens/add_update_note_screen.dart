import 'package:flutter/material.dart';
import 'components/action_button_widget.dart';
import 'components/action_icon_widget.dart';
import 'components/description_text_field_widget.dart';
import 'components/title_text_field_widget.dart';

class AddUpdateNoteScreen extends StatefulWidget {
  const AddUpdateNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddUpdateNoteScreen> createState() => _AddUpdateNoteScreenState();
}

class _AddUpdateNoteScreenState extends State<AddUpdateNoteScreen> {
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: buildActionIcon(
        icon: Icons.arrow_back,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
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
    return Padding(
      padding: EdgeInsets.only(
        left: _size.height * 0.015,
        right: _size.height * 0.015,
        bottom: _size.height * 0.015,
      ),
      child: Column(
        children: [
          TitleTextField(size: _size),
          Expanded(
            child: DescriptionTextField(size: _size),
          ),
        ],
      ),
    );
  }
}
