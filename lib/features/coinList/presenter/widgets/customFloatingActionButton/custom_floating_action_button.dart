
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../ui/icons/icons.dart';
import '../../bloc/coin_list_bloc.dart';
import '../../cubit/scrollposition_cubit.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    Key? key,
    required this.context,
    required this.scrollController,
  }) : super(key: key);

  final BuildContext context;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<ScrollPositionCubit>(),
      builder: (context, state) {
        if (context.read<ScrollPositionCubit>().state > 10) {
          return BlocBuilder<CoinListBloc, CoinListState>(
            builder: (context, state) {
              return FloatingActionButton(
                // mini: true,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                elevation: 10,
                onPressed: () {
                  scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.fastOutSlowIn,
                  );

                  // if (state is CoinListLoaded) {
                  //   context
                  //       .read<CoinListBloc>()
                  //       .add(UpdateCoinList(coinList: state.coinList));
                  // }
                },
                child: const PersoIcon(icon: PersoIcons.arrowScrollUp),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
