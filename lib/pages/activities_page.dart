import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  static const Color _appWhiteColor = Color(0xFFFFFFFF);
  static const Color _appPinkColor = Color(0xFFD41E59);
  static const Color _appBlackColor = Color(0xFF000000);
  static const Color _appBlackGreyColor = Color(0xFF252525);
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

  late PreferredSizeWidget _appBar;
  int _appBarController = 0;

  final List<String> _dropdownItemValueList = ['All', 'Habits', 'Tasks'];
  String _dropdownValue = 'All';

  @override
  Widget build(BuildContext context) {
    if (_appBarController == 0) {
      _appBar = _defaultAppBar(context);
    } else {
      _appBar = _searchAppBar(context);
    }
    return DefaultTabController(
      length: _tabNumber,
      child: Scaffold(
        appBar: _appBar,
        drawer: _drawer(context),
        body: _body(context),
        floatingActionButton: _floatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _bottomAppBar(),
      ),
    );
  }

  _defaultAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(115.0),
      child: AppBar(
        backgroundColor: _appWhiteColor,
        leading: _drawerButton(context),
        title: _title(),
        actions: _iconButtonList(),
        bottom: _tabBar(),
        elevation: 1.0,
        shadowColor: _appBarShadowColor,
      ),
    );
  }

  _searchAppBar(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.25),
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
          ),
          height: double.maxFinite,
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                width: (screenWidth * 30) / 100,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: _dropdownBorder(),
                    focusedBorder: _dropdownBorder(),
                    enabledBorder: _dropdownBorder(),
                    contentPadding: EdgeInsets.zero,
                  ),
                  value: _dropdownValue,
                  items: _dropdownItemValueList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontFamily: _defaultFontFamily,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _dropdownValue = value!;
                    });
                  },
                  elevation: 1,
                ),
              ),
              Container(
                height: 35.0,
                width: 1.0,
                color: Colors.grey.withOpacity(0.25),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _dropdownBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 0.0,
      ),
    );
  }

  _drawerButton(BuildContext context) {
    return Builder(
      builder: (context) => IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(
          FontAwesomeIcons.bars,
          color: _appPinkColor,
        ),
      ),
    );
  }

  _drawer(BuildContext context) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('MMMM dd, yyyy');
    String? formattedNow = formatter.format(now);
    formatter = DateFormat('EEEE');
    String? weekday = formatter.format(now);

    return Drawer(
      backgroundColor: _appWhiteColor,
      child: ListView(
        padding: const EdgeInsets.only(top: 32.0),
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'HabitNow',
                  style: TextStyle(
                    color: _appPinkColor,
                    fontSize: 20.0,
                    fontFamily: _defaultFontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  weekday,
                  style: const TextStyle(
                    color: _appBlackGreyColor,
                    fontFamily: _defaultFontFamily,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  formattedNow,
                  style: const TextStyle(
                    color: _appBlackGreyColor,
                    fontFamily: _defaultFontFamily,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          _drawerListTile(
            onTap: () => Navigator.pop(context),
            leading: const Icon(FontAwesomeIcons.house, color: _appPinkColor),
            title: 'Home',
            isPageOpen: true,
          ),
          _drawerListTile(
            onTap: () {},
            leading: const Icon(FontAwesomeIcons.cubes),
            title: 'Categories',
          ),
          const Divider(),
          _drawerListTile(
            onTap: () {},
            leading: const Icon(FontAwesomeIcons.fill),
            title: 'Personalize',
          ),
          _drawerListTile(
            onTap: () {},
            leading: const Icon(FontAwesomeIcons.sliders),
            title: 'Settings',
          ),
          const Divider(),
          _drawerListTile(
            onTap: () {},
            leading: _premiumIcon(),
            title: 'Get premium',
          ),
          _drawerListTile(
            onTap: () {},
            leading: const Icon(FontAwesomeIcons.solidStar),
            title: 'Rate the app',
          ),
          _drawerListTile(
            onTap: () {},
            leading: const Icon(FontAwesomeIcons.solidMessage),
            title: 'Contact us',
          ),
        ],
      ),
    );
  }

  _drawerListTile({
    required Widget leading,
    required String title,
    bool isPageOpen = false,
    required Function onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: isPageOpen ? _premiumButtonBackgroundColor : null,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        onTap: () => onTap(),
        leading: leading,
        title: Text(
          title,
          style: isPageOpen
              ? const TextStyle(color: _appPinkColor)
              : const TextStyle(),
        ),
      ),
    );
  }

  _premiumIcon({Color? backgroundColor, double? backgroundSize}) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Icon(
          FontAwesomeIcons.certificate,
          color: backgroundColor,
          size: backgroundSize,
        ),
        Icon(
          FontAwesomeIcons.check,
          color: _appWhiteColor,
          size: backgroundSize == null ? 12.0 : backgroundSize - 8.0,
        ),
      ],
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
      _iconButton(
        icon: FontAwesomeIcons.magnifyingGlass,
        onPressed: () {
          setState(() {
            _appBarController = 1;
          });
        },
      ),
      _iconButton(icon: FontAwesomeIcons.calendarWeek, onPressed: () {}),
      _iconButton(icon: FontAwesomeIcons.ellipsisVertical, onPressed: () {})
    ];
  }

  _iconButton({
    required Function onPressed,
    required IconData icon,
    Color iconColor = _appBlackGreyColor,
  }) {
    return IconButton(
      onPressed: () => onPressed(),
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
            icon: _premiumIcon(
              backgroundColor: _appPinkColor,
              backgroundSize: 18.0,
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

  _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: _appPinkColor,
      elevation: 3.0,
      tooltip: 'Add activity',
      child: const Icon(FontAwesomeIcons.plus, size: 16.0),
    );
  }

  _bottomAppBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _bottomAppBarItem(
            icon: FontAwesomeIcons.listCheck,
            label: 'Today',
            index: 0,
          ),
          _bottomAppBarItem(
            icon: FontAwesomeIcons.trophy,
            label: 'Habits',
            index: 1,
          ),
          const SizedBox(width: 50.0),
          _bottomAppBarItem(
            icon: FontAwesomeIcons.circleCheck,
            label: 'Tasks',
            index: 2,
          ),
          _bottomAppBarItem(
            icon: FontAwesomeIcons.cubes,
            label: 'Categories',
            index: 3,
          ),
        ],
      ),
    );
  }

  _bottomAppBarItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return Expanded(
      child: SizedBox(
        height: 60.0,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            radius: 200.0,
            borderRadius: BorderRadius.circular(30.0),
            onTap: () => _setSelectedBottomAppBarItem(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Icon(
                    icon,
                    size: 20.0,
                    color: index == _selectedIndex
                        ? _appPinkColor
                        : _appBlackGreyColor,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: _defaultFontFamily,
                    fontSize: 12.0,
                    color: index == _selectedIndex
                        ? _appPinkColor
                        : _appBlackGreyColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _setSelectedBottomAppBarItem(int index) {
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
