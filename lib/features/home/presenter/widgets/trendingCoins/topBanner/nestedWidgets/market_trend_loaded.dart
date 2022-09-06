import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/coinPercentage/coin_percentage_format.dart';
import '../../../../../../../core/widgets/custom_container_shimmer.dart';
import '../../../../../../coinList/presenter/bloc/coin_list_bloc.dart';
import '../../../../utils/functions.dart';
import 'market_trend_and_percentage.dart';

class MarketTrendAndPercentage extends StatelessWidget {
  const MarketTrendAndPercentage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final state = context.read<CoinListBloc>().state;
    return BlocBuilder<CoinListBloc, CoinListState>(
      builder: (context, state) {
        if (state is CoinListLoading) {
          return Row(
            children: [
              const ContainerShimmer(
                width: 100,
                height: 25,
                radius: 5,
                baseColor: Color.fromARGB(176, 255, 255, 255),
              ),
              Flexible(child: Container()),
              const ContainerShimmer(
                width: 80,
                height: 25,
                radius: 5,
                baseColor: Color.fromARGB(176, 255, 255, 255),
              ),
            ],
          );
        } else if (state is CoinListLoaded) {
          final fPercentage = CoinPercentageFormat(
              percentage: getTop100Percentage(state.coinList));
          return MarketTrendLoaded(fPercentage: fPercentage);
        }
        return Container();
      },
    );
  }
}
