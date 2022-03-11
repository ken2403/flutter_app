import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../.env.dart';
import '../../widgets/appbar.dart';

class ConditionSavePage extends StatefulWidget {
  /*
    保存した検索条件を確認•変更するページ．
    TODO:5search画面とUIが被るので冗長
  */
  // static values
  static const String title = '保存した検索条件';
  // constructor
  const ConditionSavePage({Key? key}) : super(key: key);

  @override
  State<ConditionSavePage> createState() => _ConditionSavePageState();
}

class _ConditionSavePageState extends State<ConditionSavePage> {
  // set some variables
  bool _isVacant = false;
  bool _washlet = false;
  bool _multipurpose = false;
  int _madeYear = 1990;
  bool _notRecyclePaper = false;
  bool _doublePaper = false;
  bool _seatWarmer = false;

  // widgets that set the date of manufacture
  Widget _buildDropdownButton(int madeYear, void Function(int?) update) {
    return Row(
      children: [
        const Text(
          '製造年月日',
        ),
        DropdownButton(
          value: madeYear,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          onChanged: update,
          items: <int>[1990, 2000, 2010, 2020]
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
        const Text(
          '年以降',
        ),
      ],
    );
  }

  // function to build custom switch list
  Widget _customSwitch(
    BuildContext context,
    bool value,
    void Function(bool) onChanged,
    String title,
    String subtitle,
  ) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.primary,
      activeTrackColor: Theme.of(context).colorScheme.primary.withAlpha(100),
      inactiveThumbColor: Colors.white,
      inactiveTrackColor:
          Theme.of(context).unselectedWidgetColor.withOpacity(0.4),
      title: Text(
        title,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
          color: Theme.of(context).textTheme.bodyText1!.color,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
          color: Theme.of(context).textTheme.bodyText2!.color,
        ),
      ),
      value: value,
      onChanged: onChanged,
    );
  }

  // load parameter
  Future<void> _loadSavedParams() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isVacant') == null) {
      await _paramSaver(prefs);
    }
    setState(() {
      _isVacant = prefs.getBool('isVacant')!;
      _washlet = prefs.getBool('washlet')!;
      _multipurpose = prefs.getBool('multipurpose')!;
      _madeYear = prefs.getInt('madeYear')!;
      _notRecyclePaper = prefs.getBool('notRecyclePaper')!;
      _doublePaper = prefs.getBool('doublePaper')!;
      _seatWarmer = prefs.getBool('seatWarmer')!;
    });
  }

  // save parameter
  Future<void> _paramSaver(SharedPreferences prefs) async {
    await prefs.setBool('isVacant', _isVacant);
    await prefs.setBool('washlet', _washlet);
    await prefs.setBool('multipurpose', _multipurpose);
    await prefs.setInt('madeYear', _madeYear);
    await prefs.setBool('notRecyclePaper', _notRecyclePaper);
    await prefs.setBool('doublePaper', _doublePaper);
    await prefs.setBool('seatWarmer', _seatWarmer);
  }

  @override
  void initState() {
    _loadSavedParams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, ConditionSavePage.title),
      body: Padding(
        padding: pagePadding,
        child: ListView(
          children: <Widget>[
            _customSwitch(
              context,
              _isVacant,
              (bool val) {
                setState(() {
                  _isVacant = val;
                });
              },
              '空きあり',
              '個室の空きがあるトイレのみをマップ上に表示',
            ),
            _customSwitch(
              context,
              _washlet,
              (bool val) {
                setState(() {
                  _washlet = val;
                });
              },
              'ウォシュレット',
              'ウォシュレットのあるトイレのみマップ上に表示',
            ),
            _customSwitch(
              context,
              _multipurpose,
              (bool val) {
                setState(() {
                  _multipurpose = val;
                });
              },
              '多目的トイレ',
              '多目的トイレのみをマップ上に表示',
            ),
            _customSwitch(
              context,
              _seatWarmer,
              (bool val) {
                setState(() {
                  _seatWarmer = val;
                });
              },
              '温座',
              '温座があるトイレのみをマップ上に表示',
            ),
            _buildDropdownButton(_madeYear, (int? newValue) {
              setState(() {
                _madeYear = newValue!;
              });
            }),
            _customSwitch(
              context,
              _doublePaper,
              (bool val) {
                setState(() {
                  _doublePaper = val;
                });
              },
              'ダブル',
              'トイレットペーパーがダブルのトイレのみをマップ上に表示',
            ),
            _customSwitch(
              context,
              _notRecyclePaper,
              (bool val) {
                setState(() {
                  _notRecyclePaper = val;
                });
              },
              '再生紙',
              'トイレットペーパーが再生紙でないトイレのみをマップ上に表示',
            ),
            // for landscape mode
            Container(
              padding: const EdgeInsets.all(30),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        label: Text(
          '保存する',
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          _paramSaver(prefs);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }
}
