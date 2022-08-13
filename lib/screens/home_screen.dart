import 'package:flutter/material.dart';

import '../utils/assets_constants.dart';
import 'components/action_icon_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotesKeeper'),
        actions: [
          buildActionIcon(
              iconPath: AssetsConsts.icDustbin, onTap: () {}, rightMargin: 8.0),
          buildActionIcon(
              iconPath: AssetsConsts.icSearch, onTap: () {}, rightMargin: 10.0),
        ],
      ),
    );
  }
}
