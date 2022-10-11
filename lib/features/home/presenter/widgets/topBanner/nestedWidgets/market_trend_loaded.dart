import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../core/widgets/custom_container_shimmer.dart';
import '../../../../../../ui/colors/colors.dart';
import '../../../bloc/top10/top_10_bloc.dart';
import '../../../utils/functions.dart';
import 'market_trend_and_percentage.dart';

class MarketTrendAndPercentage extends StatelessWidget {
  const MarketTrendAndPercentage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Top10Bloc, Top10State>(
      builder: (context, state) {
        if (state is Top10Loading) {
          return Row(
            children: [
              const ContainerShimmer(
                width: 100,
                height: 25,
                radius: 5,
              ),
              Flexible(child: Container()),
              const ContainerShimmer(
                width: 80,
                height: 25,
                radius: 5,
              ),
            ],
          );
        } else if (state is Top10Loaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MarketTrendLoaded(
                  percentage: getTop100Percentage(state.coinList)),
              Text(
                "in the last 24h",
                style: GoogleFonts.inter(
                    color: AppColors.mainWhite.withOpacity(0.7), fontSize: 11),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
