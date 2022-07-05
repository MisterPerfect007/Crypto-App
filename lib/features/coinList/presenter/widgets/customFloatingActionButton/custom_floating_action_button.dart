import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/icons.dart';

class CustomSpeedDial extends StatelessWidget {
  const CustomSpeedDial({
    Key? key,
    required ScrollController scrollController,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinListBloc, CoinListState>(
      builder: (context, state) {
        final bool isCoinListLoaded = state is CoinListLoaded;
        if (isCoinListLoaded) {
          return SpeedDial(
            backgroundColor: AppColors.mainBlack,
            icon: Icons.add,
            children: [
              SpeedDialChild(
                  onTap: () {
                    _scrollController.jumpTo(
                      _scrollController.position.maxScrollExtent,
                    );
                  },
                  label: "Scroll to bottom",
                  child: const RotatedBox(
                    quarterTurns: 2,
                    child: PersoIcon(icon: PersoIcons.arrowScrollUp),
                  )),
              SpeedDialChild(
                  onTap: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
                  label: "Scroll to top",
                  child: const PersoIcon(icon: PersoIcons.arrowScrollUp)),
            ]);
        } else {
          return Container();
        }
      },
    );
  }
}
