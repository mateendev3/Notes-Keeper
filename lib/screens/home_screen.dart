import 'dart:math';

import 'package:flutter/material.dart';
import '../utils/assets_constants.dart';
import '../utils/color_constants.dart';
import '../utils/helper_widgets.dart';
import 'components/action_icon_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Size _size;
  late Random _random;
  bool _showGrid = true;

  @override
  void initState() {
    super.initState();
    _random = Random();
  }

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
        child: _buildBody(context),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('NotesKeeper'),
      actions: [
        buildActionIcon(
            iconPath: AssetsConsts.icDustbin, onTap: () {}, rightMargin: 8.0),
        buildActionIcon(
            iconPath: AssetsConsts.icSearch, onTap: () {}, rightMargin: 10.0),
      ],
    );
  }

  GridView _buildNotesGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: _size.height * 0.01,
        crossAxisSpacing: _size.height * 0.01,
      ),
      itemBuilder: (context, index) {
        return _buildNotesGridItem(
          index,
          title: '10 Excellent font pairing tools for designers.',
          date: 'Aug 14, 2022',
        );
      },
    );
  }

  Widget _buildNotesGridItem(
    int index, {
    required String title,
    required String date,
  }) {
    return Card(
      color: AppColors.list[_random.nextInt(AppColors.list.length)],
      child: InkWell(
        onTap: () {},
        splashColor: AppColors.white,
        child: LayoutBuilder(builder: (context, innerConstraints) {
          return Padding(
            padding: EdgeInsets.all(innerConstraints.maxHeight * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      title,
                      maxLines: 4,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: innerConstraints.maxHeight * 0.115,
                          ),
                    ),
                  ),
                ),
                Text(
                  date,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: innerConstraints.maxHeight * 0.08,
                      ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNotesListItem(
    int index, {
    required String title,
    required String date,
  }) {
    return Card(
      color: AppColors.list[_random.nextInt(AppColors.list.length)],
      child: InkWell(
        onTap: () {},
        splashColor: AppColors.white,
        child: Padding(
          padding: EdgeInsets.all(_size.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 2,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontSize: _size.width * 0.050,
                    ),
              ),
              addVerticalSpace(_size.width * 0.015),
              Text(
                date,
                maxLines: 1,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: _size.width * 0.035,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotesListView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: _size.width * 0.01),
          child: _buildNotesListItem(
            index,
            title: 'How to make your personal brand stands out online.',
            date: 'Aug 13, 2022',
          ),
        );
      },
    );
  }

  _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: _size.height * 0.015,
            right: _size.height * 0.015,
            bottom: _size.height * 0.015,
          ),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: _size.height * 0.01,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Text(
                      'All Notes',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: AppColors.lightGray,
                          ),
                    ),
                  ),
                ),
              ),
              _buildListingIcon(AssetsConsts.icGrid, () {
                if (_showGrid) {
                  return;
                } else {
                  setState(() {
                    _showGrid = true;
                  });
                }
              }),
              _buildListingIcon(AssetsConsts.icList, () {
                if (!_showGrid) {
                  return;
                } else {
                  setState(() {
                    _showGrid = false;
                  });
                }
              }),
            ],
          ),
        ),
        Expanded(
          child: _showGrid ? _buildNotesGridView() : _buildNotesListView(),
        ),
      ],
    );
  }

  IconButton _buildListingIcon(String path, VoidCallback onPressed) {
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
}
