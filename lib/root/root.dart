import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_trends/features/coinList/presenter/pages/coin_list_page.dart';
import 'package:crypto_trends/features/favorites/presenter/pages/favorite_page.dart';
import 'package:crypto_trends/features/home/presenter/page/home_page.dart';
import 'package:crypto_trends/features/search/presenter/page/search.dart';
import 'package:crypto_trends/features/settings/presenter/pages/settings_page.dart';
import 'package:crypto_trends/root/widgets/custom_animated_widget.dart';
import 'package:crypto_trends/services/firebase/auth/utils.dart';
import 'package:crypto_trends/ui/icons/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../features/favorites/utils/utils.dart';
import '../ui/colors/colors.dart';
import 'widgets/bottom_bar_item.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      value: 1,
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    //! Remove the splash screen
    WidgetsBinding.instance
        .addPostFrameCallback((_) => FlutterNativeSplash.remove());
    //
    
  }

  void _handlePageSwitch(int newindex) {
    if (newindex != _currentIndex) {
      setState(() {
        _currentIndex = newindex;
      });
      //do the animation
      _animationController.reset();
      _animationController.forward();
    }
  }

  int _currentIndex = 0;

  final List<List<dynamic>> _itemList = [
    ["Home", SvgIcons.homeRegular, SvgIcons.homeFilled],
    ["List", SvgIcons.listLine, SvgIcons.listSolid],
    ["Search", SvgIcons.search, SvgIcons.search],
    ["Favorites", SvgIcons.favoriteLine, SvgIcons.favoriteSolid],
    ["Settings", SvgIcons.settingsOutline, SvgIcons.settingsFill],
  ];

  @override
  Widget build(BuildContext context) {
    //
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    //All pages
    final List<Widget> _pages = [
      const HomePage(),
      const CoinListPage(),
      const Search(),
      const FavoritePage(),
      const SettingsPage(),
    ]
        .map((e) => CustomAnimatedWidget(animation: _animation, child: e))
        .toList();

    final double displayWidth = MediaQuery.of(context).size.width;
    //!
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButton:
          keyboardIsOpened ? null : buildBottomNavigationBar(displayWidth),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  SafeArea buildBottomNavigationBar(double displayWidth) {
    //
    final theme = Theme.of(context);
    return SafeArea(
        child: Container(
      constraints: const BoxConstraints(
        maxWidth: 350,
        // minWidth: 200,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      width: displayWidth * 0.8,
      height: 50,
      decoration: BoxDecoration(
          color: theme.bottomAppBarColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: theme.primaryColor,
                blurRadius: 1,
                spreadRadius: 0.5,
                offset: const Offset(0, 0))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List<Widget>.generate(_itemList.length, (index) {
          final bool itemIsSelected = _currentIndex == index;
          return BottomBarItem(
            label: _itemList[index][0],
            icon: itemIsSelected ? _itemList[index][2] : _itemList[index][1],
            color: itemIsSelected ? AppColors.mainGreen : AppColors.mainGrey,
            onTap: () => _handlePageSwitch(index),
          );
        }).toList(),
      ),
    ));
  }
}
