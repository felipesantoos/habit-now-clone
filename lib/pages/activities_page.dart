import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  static const Color _appWhiteColor = Color(0xFFFFFFFF);
  static const Color _appPinkColor = Color(0xFFD41E59);
  static const Color _appBlackColor = Color(0xFF000000);
  static const Color _greyIconColor = Color(0xFF252525);
  static const Color _appGreyForegroundColor = Color(0xFF808080);
  static const Color _appGreyBackgroundColor = Color(0xFFF6F6F6);

  final int _tabNumber = 7;
  int _selectedTabNumber = 0;

  List<TabBarItemData> tabBarItemDataList = [
    TabBarItemData(weekDayName: 'Sun', monthDayNumber: 1),
    TabBarItemData(weekDayName: 'Mon', monthDayNumber: 2),
    TabBarItemData(weekDayName: 'Tue', monthDayNumber: 3),
    TabBarItemData(weekDayName: 'Wed', monthDayNumber: 4, isToday: true),
    TabBarItemData(weekDayName: 'Thu', monthDayNumber: 5),
    TabBarItemData(weekDayName: 'Fri', monthDayNumber: 6),
    TabBarItemData(weekDayName: 'Sat', monthDayNumber: 7),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabNumber,
      child: Scaffold(
        appBar: _appBar(),
      ),
    );
  }

  _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(115.0),
      child: AppBar(
        backgroundColor: _appWhiteColor,
        leading: _drawerButton(),
        title: _title(),
        actions: _iconButtonList(),
        bottom: _tabBar(),
        elevation: 0.25,
        shadowColor: Colors.grey,
      ),
    );
  }

  _drawerButton() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        FontAwesomeIcons.bars,
        color: _appPinkColor,
      ),
    );
  }

  _title() {
    return const Text(
      'Today',
      style: TextStyle(
        color: _appBlackColor,
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

  _tabBar() {
    return TabBar(
      overlayColor: MaterialStateColor.resolveWith(
        (states) => Colors.transparent,
      ),
      labelPadding: const EdgeInsets.all(0.0),
      indicator: const UnderlineTabIndicator(),
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
      onTap: _onTapTabBar,
      tabs: [
        for (int i = 0; i < _tabNumber; i++)
          Tab(
            child: _tabBarItem(
              weekDayName: tabBarItemDataList[i].weekDayName,
              monthDayNumber: tabBarItemDataList[i].monthDayNumber,
              isSelected: tabBarItemDataList[i].isSelected!,
              isToday: tabBarItemDataList[i].isToday!,
            ),
          ),
      ],
    );
  }

  _onTapTabBar(index) {
    for (int i = 0; i < _tabNumber; i++) {
      if (i == index) {
        setState(() {
          tabBarItemDataList[_selectedTabNumber].isSelected = false;
          tabBarItemDataList[i].isSelected = true;
          _selectedTabNumber = i;
        });
      }
    }
  }

  _tabBarItem({
    required String weekDayName,
    required int monthDayNumber,
    bool isSelected = false,
    bool isToday = false,
    Color labelColor = _appGreyForegroundColor,
  }) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isSelected ? _appPinkColor : _appGreyBackgroundColor,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Column(
              children: <Widget>[
                Text(
                  weekDayName,
                  style: TextStyle(
                    color: isSelected ? _appWhiteColor : labelColor,
                  ),
                ),
                Text(
                  monthDayNumber.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: isSelected ? _appWhiteColor : labelColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        isToday
            ? Container(
                height: 3.0,
                width: 12.0,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white70 : labelColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}

class TabBarItemData {
  String weekDayName;
  int monthDayNumber;
  bool? isSelected;
  bool? isToday;

  TabBarItemData({
    required this.weekDayName,
    required this.monthDayNumber,
    this.isSelected = false,
    this.isToday = false,
  });
}
