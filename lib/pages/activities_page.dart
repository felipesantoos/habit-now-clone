import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  final Color _whiteAppBarColor = const Color(0xFFFFFFFF);
  final Color _pinkIconColor = const Color(0xFFA82956);
  final Color _titleColor = const Color(0xFF000000);
  final Color _greyIconColor = const Color(0xFF252525);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: _whiteAppBarColor,
      leading: _drawerButton(),
      title: _title(),
      actions: _iconButtonList(),
    );
  }

  _drawerButton() {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        FontAwesomeIcons.bars,
        color: _pinkIconColor,
      ),
    );
  }

  _title() {
    return Text(
      'Today',
      style: TextStyle(
        color: _titleColor,
        fontWeight: FontWeight.bold,
        fontFamily: 'Ubuntu',
      ),
    );
  }

  _iconButtonList() {
    return <Widget>[
      _iconButton(
        icon: FontAwesomeIcons.magnifyingGlass,
        iconColor: _greyIconColor,
        onPressed: () {},
      ),
      _iconButton(
        icon: FontAwesomeIcons.calendarWeek,
        iconColor: _greyIconColor,
        onPressed: () {},
      ),
      _iconButton(
        icon: FontAwesomeIcons.ellipsisVertical,
        iconColor: _greyIconColor,
        onPressed: () {},
      )
    ];
  }

  _iconButton({Function? onPressed, IconData? icon, Color? iconColor}) {
    return IconButton(
      onPressed: () => onPressed,
      icon: Icon(icon, color: iconColor),
    );
  }
}
