import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/fonts.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    required this.tabNumber,
    this.initialSelectedTabNumber = 0,
    required this.tabBarItemDataList,
    Key? key,
  }) : super(key: key);

  final int tabNumber;
  final int initialSelectedTabNumber;
  final List<TabBarItemData> tabBarItemDataList;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  late int _selectedTabNumber = widget.initialSelectedTabNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: TabBar(
        overlayColor: MaterialStateColor.resolveWith(
          (states) => Colors.transparent,
        ),
        labelPadding: const EdgeInsets.all(0.0),
        indicator: const UnderlineTabIndicator(),
        padding: const EdgeInsets.only(
          left: 8.0,
          top: 4.0,
          right: 8.0,
          bottom: 14.0,
        ),
        onTap: _onTapTabBar,
        tabs: [
          for (int i = 0; i < widget.tabNumber; i++)
            Tab(
              child: _tabBarItem(
                weekDayName: widget.tabBarItemDataList[i].weekDayName,
                monthDayNumber: widget.tabBarItemDataList[i].monthDayNumber,
                isSelected: widget.tabBarItemDataList[i].isSelected!,
                isToday: widget.tabBarItemDataList[i].isToday!,
              ),
            ),
        ],
      ),
    );
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
            color:
                isSelected ? CustomColors.appPinkColor : CustomColors.appGreyBC,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Column(
              children: <Widget>[
                Text(
                  weekDayName,
                  style: TextStyle(
                    color: isSelected
                        ? CustomColors.appWhiteColor
                        : CustomColors.appGreyFC,
                    fontFamily: CustomFonts.defaultFontFamily,
                  ),
                ),
                Text(
                  monthDayNumber.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: isSelected
                        ? CustomColors.appWhiteColor
                        : CustomColors.appGreyFC,
                    fontFamily: CustomFonts.defaultFontFamily,
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
                  color: isSelected ? Colors.white70 : CustomColors.appGreyFC,
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

  _onTapTabBar(index) {
    for (int i = 0; i < widget.tabNumber; i++) {
      if (i == index) {
        setState(() {
          widget.tabBarItemDataList[_selectedTabNumber].isSelected = false;
          widget.tabBarItemDataList[i].isSelected = true;
          _selectedTabNumber = i;
        });
      }
    }
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
