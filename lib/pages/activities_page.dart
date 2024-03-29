import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../components/tab_bar.dart';
import '../utils/colors.dart';
import '../utils/fonts.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  // AppBar
  late PreferredSizeWidget _appBar;
  int _appBarController = 0;

  // Dropdown
  final List<String> _dropdownItemValueList = ['All', 'Habits', 'Tasks'];
  String _dropdownValue = 'All';

  // TabBar
  final int _tabNumber = 7;
  final List<TabBarItemData> _tabBarItemDataList = [
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

  // Premium button
  bool _showPremiumButton = true;

  // BottomAppBar
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    _chooseAppBar(context);
    return DefaultTabController(
      length: _tabNumber,
      child: Scaffold(
        appBar: _buildAppBar(),
        drawer: _drawer(context),
        body: _body(context),
        floatingActionButton: _floatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _bottomAppBar(),
      ),
    );
  }

  _chooseAppBar(BuildContext context) {
    if (_appBarController == 0) {
      _appBar = _defaultAppBar(context);
    } else {
      _appBar = _searchAppBar(context);
    }
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(123.0),
      child: Column(
        children: <Widget>[
          _appBar,
          CustomTabBar(
            tabNumber: _tabNumber,
            tabBarItemDataList: _tabBarItemDataList,
            initialSelectedTabNumber: 3,
          ),
        ],
      ),
    );
  }

  _defaultAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 56.0,
      backgroundColor: CustomColors.appWhiteColor,
      leading: _drawerButton(context),
      title: _title(),
      actions: _iconButtonList(),
      elevation: 0,
    );
  }

  PreferredSize _searchAppBar(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: const Size.fromHeight(56.0),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            top: 4.0,
            left: 6.0,
            right: 8.0,
            bottom: 4.0,
          ),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Material(
                color: Colors.white,
                child: SizedBox(
                  height: 40.0,
                  width: (screenWidth * 25) / 100,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: _dropdownBorder(),
                      focusedBorder: _dropdownBorder(),
                      enabledBorder: _dropdownBorder(),
                      contentPadding: const EdgeInsets.only(left: 8.0),
                    ),
                    value: _dropdownValue,
                    items: _dropdownItemValueList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontFamily: CustomFonts.defaultFontFamily,
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
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                height: 35.0,
                width: 1.0,
                color: Colors.grey.withOpacity(0.25),
              ),
              SizedBox(
                width: (screenWidth * 55) / 100,
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    border: _textFieldBorder(),
                    focusedBorder: _textFieldBorder(),
                    enabledBorder: _textFieldBorder(),
                    hintStyle: const TextStyle(
                      fontSize: 14.0,
                    ),
                    hintText: 'Type a name or category',
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () => setState(() => _appBarController = 0),
                  child: const Icon(FontAwesomeIcons.xmark),
                ),
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

  _textFieldBorder() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 0.0,
      ),
    );
  }

  _drawerButton(BuildContext context) {
    return Builder(
      builder: (context) => IconButton(
        splashRadius: 25.0,
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(
          FontAwesomeIcons.bars,
          color: CustomColors.appPinkColor,
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
      backgroundColor: CustomColors.appWhiteColor,
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
                    color: CustomColors.appPinkColor,
                    fontSize: 20.0,
                    fontFamily: CustomFonts.defaultFontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  weekday,
                  style: const TextStyle(
                    color: CustomColors.appBlackGreyColor,
                    fontFamily: CustomFonts.defaultFontFamily,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  formattedNow,
                  style: const TextStyle(
                    color: CustomColors.appBlackGreyColor,
                    fontFamily: CustomFonts.defaultFontFamily,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          _drawerListTile(
            onTap: () => Navigator.pop(context),
            leading: const Icon(FontAwesomeIcons.house,
                color: CustomColors.appPinkColor),
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
        color: isPageOpen ? CustomColors.premiumButtonBackgroundColor : null,
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
              ? const TextStyle(color: CustomColors.appPinkColor)
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
          color: CustomColors.appWhiteColor,
          size: backgroundSize == null ? 12.0 : backgroundSize - 8.0,
        ),
      ],
    );
  }

  _title() {
    return const Text(
      'Today',
      style: TextStyle(
        color: CustomColors.appBlackColor,
        fontWeight: FontWeight.bold,
        fontFamily: CustomFonts.defaultFontFamily,
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
    Color iconColor = CustomColors.appBlackGreyColor,
  }) {
    return IconButton(
      splashRadius: 25.0,
      onPressed: () => onPressed(),
      icon: Icon(icon, color: iconColor),
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
    return SizedBox(
      height: screenHeight - 145.0,
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
                  fontFamily: CustomFonts.defaultFontFamily,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Add new activities',
                style: TextStyle(
                  color: CustomColors.appGreyFC,
                  fontSize: 16.0,
                  fontFamily: CustomFonts.defaultFontFamily,
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
                return CustomColors.premiumButtonBackgroundColor;
              }),
            ),
            onPressed: () {},
            icon: _premiumIcon(
              backgroundColor: CustomColors.appPinkColor,
              backgroundSize: 18.0,
            ),
            label: const Text(
              'Premium',
              style: TextStyle(
                color: CustomColors.appPinkColor,
                fontFamily: CustomFonts.defaultFontFamily,
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
                  color: CustomColors.closePremiumButtonBCIcon,
                  borderRadius: BorderRadius.circular(8.0)),
              child: const Icon(
                Icons.close,
                size: 8.0,
                color: CustomColors.appWhiteColor,
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
      backgroundColor: CustomColors.appPinkColor,
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
                        ? CustomColors.appPinkColor
                        : CustomColors.appBlackGreyColor,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: CustomFonts.defaultFontFamily,
                    fontSize: 12.0,
                    color: index == _selectedIndex
                        ? CustomColors.appPinkColor
                        : CustomColors.appBlackGreyColor,
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
