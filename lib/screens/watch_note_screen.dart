import 'package:flutter/material.dart';
import 'package:notes_keeper/utils/assets_constants.dart';
import 'package:notes_keeper/utils/helper_widgets.dart';

import '../utils/color_constants.dart';
import 'components/action_icon_widget.dart';

class WatchNoteScreen extends StatefulWidget {
  const WatchNoteScreen({Key? key}) : super(key: key);

  @override
  State<WatchNoteScreen> createState() => _WatchNoteScreenState();
}

class _WatchNoteScreenState extends State<WatchNoteScreen> {
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          top: _size.height * 0.02,
          left: _size.height * 0.035,
          right: _size.height * 0.035,
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
        buildActionIcon(
          onTap: () {},
          rightMargin: 15.0,
          iconPath: AssetsConsts.icDustbin,
        ),
        buildActionIcon(
          onTap: () {},
          rightMargin: 15.0,
          icon: Icons.edit_outlined,
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildTitleText(),
        addVerticalSpace(_size.height * 0.04),
        Expanded(
          child: SingleChildScrollView(
            child: _buildNoteText(),
          ),
        ),
      ],
    );
  }

  Text _buildTitleText() {
    return Text(
      'How to work as a developer in Pakistan.',
      maxLines: null,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: AppColors.white,
            fontSize: _size.width * 0.08,
            fontWeight: FontWeight.w500,
          ),
    );
  }

  final String _data = '''
Apart from counting words and characters, our online editor can help you to improve word choice and writing style, and, optionally, help you to detect grammar mistakes and plagiarism. To check word count, simply place your cursor into the text box above and start typing. You'll see the number of characters and words increase or decrease as you type, delete, and edit them. You can also copy and paste text from another program over into the online editor above. The Auto-Save feature will make sure you won't lose any changes while editing, even if you leave the site and come back later. Tip: Bookmark this page now.
Knowing the word count of a text can be important. For example, if an author has to write a minimum or maximum amount of words for an article, essay, report, story, book, paper, you name it. WordCounter will help to make sure its word count reaches a specific requirement or stays within a certain limit.
In addition, WordCounter shows you the top 10 keywords and keyword density of the article you're writing. This allows you to know which keywords you use how often and at what percentages. This can prevent you from over-using certain words or word combinations and check for best distribution of keywords in your writing.
In the Details overview you can see the average speaking and reading time for your text, while Reading Level is an indicator of the education level a person would need in order to understand the words you’re using.
Disclaimer: We strive to make our tools as accurate as possible but we cannot guarantee it will always be so.
''';

  _buildNoteText() {
    return Text(
      _data,
      maxLines: null,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: _size.width * 0.05,
          ),
    );
  }
}
