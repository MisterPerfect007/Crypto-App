import 'package:crypto_trends/features/coinList/presenter/pages/coin_list_page.dart';
import 'package:crypto_trends/features/home/presenter/page/home_page.dart';
import 'package:crypto_trends/ui/icons/svg-icons.dart';
import 'package:flutter/material.dart';

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
  }

  void _handlePageSwitch(int newindex) {
    if (newindex != _currentIndex) {
      setState(() {
        _currentIndex = newindex;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  int _currentIndex = 0;

  final List<List<dynamic>> _itemList = [
    ["Home", SvgIcons.homeRegular, SvgIcons.homeFilled],
    ["List", SvgIcons.listLine, SvgIcons.listSolid],
    ["Settings", SvgIcons.settingsOutline, SvgIcons.settingsFill]
  ];

  @override
  Widget build(BuildContext context) {
    //All pages
    final List<Widget> _pages = [
      const HomePage(),
      const CoinListPage(),
      //!Missing the Settings page
    ]
        .map((e) => CustomAnimatedWidget(animation: _animation, child: e))
        .toList();

    final double displayWidth = MediaQuery.of(context).size.width;
    //
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButton: buildBottomNavigationBar(displayWidth),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  SafeArea buildBottomNavigationBar(double displayWidth) {
    return SafeArea(
        child: Container(
      constraints: const BoxConstraints(
        maxWidth: 300,
        minWidth: 150,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      // padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      width: displayWidth * 0.6,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 2,
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

class CustomAnimatedWidget extends AnimatedWidget {
  const CustomAnimatedWidget(
      {key, required this.animation, required this.child})
      : super(
          key: key,
          listenable: animation,
        );

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: child,
    );
  }
}
