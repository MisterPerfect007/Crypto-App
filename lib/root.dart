import 'package:crypto_trends/features/coinList/presenter/pages/coin_list_page.dart';
import 'package:crypto_trends/features/home/presenter/page/home_page.dart';
import 'package:crypto_trends/ui/icons/svg-icons.dart';
import 'package:flutter/material.dart';

import 'ui/colors/colors.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> with TickerProviderStateMixin{
  late AnimationController _animationController ;
  late Animation<double> _animation;

  @override
  void initState(){
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));

    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    _animationController.animateTo(500);
  }


  int _currentIndex = 0;

  final List _itemList = [
    ["Home", SvgIcons.homeFilled],
    ["List", SvgIcons.listLine],
    ["Settings", SvgIcons.settingsOutline]
  ];

  @override
  Widget build(BuildContext context) {
  final List<Widget> _pages = [
    ScaleTransition(child: HomePage(), scale: _animation),
    CoinListPage()

  ];
    final double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: IndexedStack(
        index:  _currentIndex,
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
            icon: _itemList[index][1],
            color: itemIsSelected ? AppColors.mainGreen : AppColors.mainGrey,
            onTap: () => setState(() {
              _currentIndex = index;
              _animationController.animateTo(500);
            }),
          );
        }).toList(),
      ),
    ));
  }
}

class BottomBarItem extends StatelessWidget {
  final Function() onTap;
  final String label;
  final SvgIcons icon;
  final Color color;
  const BottomBarItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        splashColor: AppColors.mainGreen.withOpacity(0.5),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgIcon(icon: icon, size: 18, color: color),
              Text(
                label,
                style: TextStyle(fontSize: 9, color: color),
              )
            ],
          ),
        ),
      ),
    );
  }
}
