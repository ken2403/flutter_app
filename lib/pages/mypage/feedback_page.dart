import 'package:flutter/material.dart';

import '../../widgets/appbar.dart';

class FeedBackPage extends StatefulWidget {
  /*
    TODO:説明
  */
  // static values
  static const String title = 'フィードバック';
  // constructor
  const FeedBackPage({Key? key}) : super(key: key);

  @override
  State<FeedBackPage> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, FeedBackPage.title),
      body: const Center(
        child: Text(FeedBackPage.title),
      ),
    );
  }
}
