import 'package:crypto_trends/features/coinList/presenter/cubit/pagination_cubit.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:crypto_trends/ui/icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/coin.dart';
import 'single coin/single_coin.dart';

class CoinListView extends StatefulWidget {
  const CoinListView({
    Key? key,
    required ScrollController scrollController,
    required this.coinList,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final List<Coin> coinList;

  @override
  State<CoinListView> createState() => _CoinListViewState();
}

class _CoinListViewState extends State<CoinListView> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _opacity = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: _opacity,
      child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: widget._scrollController,
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: widget.coinList.length + 1,
          itemBuilder: ((context, i) {
            final coinList = widget.coinList;
            if (i == widget.coinList.length) {
              return const PaginationParentWidget();
            } else if (i < widget.coinList.length) {
              return SingleCoin(
                id: coinList[i].id,
                name: coinList[i].name,
                image: coinList[i].image,
                symbol: coinList[i].symbol,
                currentPrice: coinList[i].currentPrice,
                marketCapRank: coinList[i].marketCapRank,
                priceChangePercentage7dInCurrency:
                    coinList[i].priceChangePercentage7dInCurrency,
                lastWeekData: coinList[i].sparklineIn7d?.price,
              );
            } else {
              return const Text("");
            }
          })),
    );
  }
}

class PaginationParentWidget extends StatelessWidget {
  const PaginationParentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return BlocBuilder(
      bloc: context.read<PaginationCubit>(),
      builder: (context, int state) {
        bool isFisrtPage() {
          return state == 1;
        }

        bool isLastPage() {
          return state == 100;
        }

        return Container(
            padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(),
                  onPressed: isFisrtPage()
                      ? null
                      : () {
                          context.read<PaginationCubit>().prevPage();
                        },
                  child: PersoIcon(
                    icon: PersoIcons.angleLeft,
                    color: isFisrtPage()
                        ? AppColors.secondGrey
                        : AppColors.mainGreen,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                DropdownButton<int>(
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainBlack),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  alignment: AlignmentDirectional.topCenter,
                  menuMaxHeight: 200,
                  value: state,
                  items: List<int>.generate(100, (index) => index + 1)
                      .map((e) => DropdownMenuItem<int>(
                            alignment: AlignmentDirectional.center,
                            value: e,
                            child: Text(e.toString()),
                          ))
                      .toList(),
                  onChanged: (page) {
                    if(page != state){print(page);};
                    context.read<PaginationCubit>().changePage(page!);
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(),
                  onPressed: isLastPage()
                      ? null
                      : () {
                          context.read<PaginationCubit>().nextPage();
                        },
                  child: PersoIcon(
                    icon: PersoIcons.angleRight,
                    color: isLastPage()
                        ? AppColors.secondGrey
                        : AppColors.mainGreen,
                  ),
                ),
              ],
            ));
      },
    );
  }
}
