import 'package:flutter/material.dart';

import '../../widgets/appbar.dart';

class ToiletSavePage extends StatefulWidget {
  /*
    TODO:説明
  */
  // static values
  static const String title = '保存したトイレ';
  // constructor
  const ToiletSavePage({Key? key}) : super(key: key);

  @override
  State<ToiletSavePage> createState() => _ToiletSavePageState();
}

class _ToiletSavePageState extends State<ToiletSavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, ToiletSavePage.title),
      body: const Center(
        child: Text(ToiletSavePage.title),
      ),
    );
  }
}
