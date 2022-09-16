import 'package:animations/animations.dart';
import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'package:crypto_trends/features/search/presenter/page/search.dart';
import 'package:crypto_trends/ui/icons/svg-icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_trends/injection_container.dart' as di;

import '../../../../ui/colors/colors.dart';
import '../../../search/presenter/bloc/search_coin_bloc.dart';
import '../../domain/entities/coin.dart';

class CoinPageAppBar extends StatelessWidget {
  const CoinPageAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double sidePadding = width / 25;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          left: size.width / 25,
          right: size.width / 25,
        ),
        height: 50,
        child: Row(children: [
          const Text(
            "Coin List",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.pureBlack,
            ),
          ),
          Expanded(child: Container()),
          BlocBuilder<CoinListBloc, CoinListState>(builder: (context, state) {
            List<Coin> coinList = [];
            if (state is CoinListLoaded) {
              coinList = state.coinList;
            }
            return OpenContainer(
                closedElevation: 0.0,
                closedShape: const CircleBorder(),
                closedBuilder: (context, action) => InkWell(
                      splashColor: const Color.fromARGB(255, 199, 199, 199),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      onTap: action,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.mainGreen.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const SvgIcon(
                          icon: SvgIcons.search,
                          color: AppColors.mainGreen,
                          size: 18,
                        ),
                      ),
                    ),
                openBuilder: (context, action) => BlocProvider(
                      create: (context) => di.sl<SearchCoinBloc>(),
                      child: Search(
                        coinList: coinList,
                      ),
                    ));
          }),
        ]),
      ),
    );
  }
}
