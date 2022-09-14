import 'package:flutter/material.dart';

import '../../../../ui/colors/colors.dart';
import '../../../../ui/icons/svg-icons.dart';
import '../../../coinList/domain/entities/coin.dart';
import '../widgets/search_item.dart';
import '../widgets/search_item_shimmer.dart';

class Search extends StatelessWidget {
  final List<Coin>? coinList;
  const Search({Key? key, this.coinList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double sidePadding = width / 25;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          50,
        ),
        child: SafeArea(
          child: Container(
              height: 50,
              color: Colors.white,
              padding: EdgeInsets.only(left: 0, right: sidePadding),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                          splashColor: Colors.grey,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              child: const SvgIcon(icon: SvgIcons.arrowLeft))),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      padding: const EdgeInsets.only(
                        left: 5,
                        right: 5,
                        // top:5,
                        // bottom: 5
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SvgIcon(
                              icon: SvgIcons.search,
                              size: 15,
                              color: Color.fromARGB(188, 0, 0, 0)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                                cursorWidth: 1.0,
                                autofocus: true,
                                cursorColor: AppColors.mainGreen,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Search coin...",
                                  hintStyle: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 10),
                                ),
                                style: const TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ))
                  ])),
        ),
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SearchItemShimmer(),
              SearchItem(),
              SearchItem(),
              SearchItem(),
            ],
          ),
        ),
      ),
    );
  }
}


