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
  static const Color _appGreyIconColor = Color(0xFF252525);
  static const Color _appGreyFC = Color(0xFF808080);
  static const Color _appGreyBC = Color(0xFFF6F6F6);
  static const Color _premiumButtonBackgroundColor = Color(0x80ffe6e6);
  static const Color _appBarShadowColor = Color(0x209E9E80);
  static const Color _closePremiumButtonBCIcon = Color(0x10000000);

  static const String _defaultFontFamily = 'Ubuntu';

  final int _tabNumber = 7;
  int _selectedTabNumber = 3;

  List<TabBarItemData> tabBarItemDataList = [
    TabBarItemData(weekDayName: 'Sun', monthDayNumber: 1),
    TabBarItemData(weekDayName: 'Mon', monthDayNumber: 2),
    TabBarItemData(weekDayName: 'Tue', monthDayNumber: 3),
    TabBarItemData(
      weekDayName: 'Wed',
      monthDayNumber: 4,
      isSelected: true,
      isToday: true,
    ),
    TabBarItemData(weekDayName: 'Thu', monthDayNumber: 5),
    TabBarItemData(weekDayName: 'Fri', monthDayNumber: 6),
    TabBarItemData(weekDayName: 'Sat', monthDayNumber: 7),
  ];

  bool _showPremiumButton = true;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabNumber,
      child: Scaffold(
        appBar: _appBar(),
        body: _body(context),
        bottomNavigationBar: _bottomNavigationBar(),
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
        elevation: 1.0,
        shadowColor: _appBarShadowColor,
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
        fontFamily: _defaultFontFamily,
      ),
    );
  }

  _iconButtonList() {
    return <Widget>[
      _iconButton(icon: FontAwesomeIcons.magnifyingGlass, onPressed: () {}),
      _iconButton(icon: FontAwesomeIcons.calendarWeek, onPressed: () {}),
      _iconButton(icon: FontAwesomeIcons.ellipsisVertical, onPressed: () {})
    ];
  }

  _iconButton({
    Function? onPressed,
    IconData? icon,
    Color? iconColor = _appGreyIconColor,
  }) {
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
  }) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isSelected ? _appPinkColor : _appGreyBC,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Column(
              children: <Widget>[
                Text(
                  weekDayName,
                  style: TextStyle(
                    color: isSelected ? _appWhiteColor : _appGreyFC,
                    fontFamily: _defaultFontFamily,
                  ),
                ),
                Text(
                  monthDayNumber.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: isSelected ? _appWhiteColor : _appGreyFC,
                    fontFamily: _defaultFontFamily,
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
                  color: isSelected ? Colors.white70 : _appGreyFC,
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

  _body(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        _thereIsNotActivities(context),
        _showPremiumButton
            ? Positioned(
                right: 10.0,
                bottom: 2.0,
                child: _premiumButton(),
              )
            : Container(),
      ],
    );
  }

  _thereIsNotActivities(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: _appWhiteColor,
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: (screenHeight - 115.0) / 4.0,
            bottom: 15.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Image(
                width: 75.0,
                image: AssetImage(
                  'images/calendar_icon.png',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'There is nothing scheduled',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  fontFamily: _defaultFontFamily,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Add new activities',
                style: TextStyle(
                  color: _appGreyFC,
                  fontSize: 16.0,
                  fontFamily: _defaultFontFamily,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _premiumButton() {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(right: 3.0),
          child: ElevatedButton.icon(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              elevation: MaterialStateProperty.resolveWith((states) => 0.0),
              backgroundColor: MaterialStateColor.resolveWith((states) {
                return _premiumButtonBackgroundColor;
              }),
            ),
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.solidStar,
              size: 14.0,
              color: _appPinkColor,
            ),
            label: const Text(
              'Premium',
              style: TextStyle(
                color: _appPinkColor,
                fontFamily: _defaultFontFamily,
              ),
            ),
          ),
        ),
        Positioned(
          top: 3.0,
          child: GestureDetector(
            onTap: _closePremiumButton,
            child: Container(
              padding: const EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                  color: _closePremiumButtonBCIcon,
                  borderRadius: BorderRadius.circular(8.0)),
              child: const Icon(
                Icons.close,
                size: 8.0,
                color: _appWhiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _closePremiumButton() {
    setState(() {
      _showPremiumButton = false;
    });
  }

  _bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: _appWhiteColor,
      elevation: 5.0,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _setSelectedBottomNavigationItem,
      selectedItemColor: _appPinkColor,
      selectedIconTheme: const IconThemeData(size: 16.0),
      selectedFontSize: 12.0,
      selectedLabelStyle: const TextStyle(
        fontFamily: _defaultFontFamily,
        fontWeight: FontWeight.bold,
      ),
      unselectedIconTheme: const IconThemeData(size: 16.0),
      unselectedFontSize: 12.0,
      unselectedLabelStyle: const TextStyle(fontFamily: _defaultFontFamily),
      items: <BottomNavigationBarItem>[
        _bottomNavigationBarItem(
          icon: FontAwesomeIcons.listCheck,
          label: 'Today',
        ),
        _bottomNavigationBarItem(
          icon: FontAwesomeIcons.trophy,
          label: 'Habits',
        ),
        _bottomNavigationBarItem(
          icon: FontAwesomeIcons.circleCheck,
          label: 'Tasks',
        ),
        _bottomNavigationBarItem(
          icon: FontAwesomeIcons.cubes,
          label: 'Categories',
        ),
      ],
    );
  }

  _bottomNavigationBarItem({required IconData? icon, required String? label}) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Icon(icon),
      ),
      label: label,
    );
  }

  _setSelectedBottomNavigationItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
