import 'package:crypto_trends/features/coinInfo/presenter/widgets/coinNameImage/coin_name_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_network_image.dart';
import '../../../../ui/colors/colors.dart';
import '../../../../ui/icons/svg-icons.dart';
import '../../../coinList/domain/entities/coin.dart';

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
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
          child: Column(
            children: [
              SearchItem(),
              SizedBox(height: 5),
              SearchItem(),
              SizedBox(height: 5),
              SearchItem(),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  const SearchItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: AppColors.mainGrey,
        child: Row(
          children: [
        const CustomNetworkImage(
          image:
              "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
          name: "name",
          width: 25,
        ),
        const SizedBox(width: 10),
        const Text(
          "Bitcoin",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 5,),
        const Text(
          "BIT",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.mainGrey
          ),
        ),
        Expanded(child: Container()),
        const Text(
          "#1",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.mainGrey
          ),
        ),
          ],
        ),
      ),
    );
  }
}
