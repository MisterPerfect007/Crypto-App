import 'package:crypto_trends/errors/error_types.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:crypto_trends/ui/icons/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../../../errors/error_types.dart';
import '../../../coinList/domain/entities/coin.dart';
import '../../domain/entity/search_coin.dart';
import '../bloc/search_coin_bloc.dart';
import '../widgets/search_app_bar.dart';
import '../widgets/search_item.dart';

class Search extends StatefulWidget {
  final List<Coin>? coinList;
  const Search({Key? key, this.coinList}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  
  List<SearchCoin> currentSearchResult = [];
  int lastSearchResult = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // double sidePadding = size.width / 25;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          50,
        ),
        child: const SearchAppBar(),
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                buildTop(),
                buildBottom(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocBuilder<SearchCoinBloc, SearchCoinState> buildTop() {
    return BlocBuilder<SearchCoinBloc, SearchCoinState>(
      builder: (context, state) {
        if (state is SearchCoinLoading) {
          return const NoInternet(
            duration: Duration(milliseconds: 200),
            icon: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: AppColors.mainGreen,
                strokeWidth: 2.0,
              ),
            ),
          );
        }
        if (state is SearchCoinLoaded) {
          final coinsList = state.coinsList;
          final requestTime = state.requestTime;

          // print(coinsList.first);
          if (coinsList.isNotEmpty &&
              (requestTime >=
                  lastSearchResult) /* should show the latest result */) {
            currentSearchResult = coinsList;
            lastSearchResult = requestTime;
            return CustomOpacityAnimation(
              child: Column(
                  children: List<SearchItem>.generate(
                      coinsList.length,
                      (index) => SearchItem(
                            name: coinsList[index].name,
                            symbol: coinsList[index].symbol,
                            image: coinsList[index].image,
                            rank: coinsList[index].marketCapRank,
                            id: coinsList[index].id,
                          ))),
            );
          } else if (coinsList.isEmpty) {
            return NoInternet(text: "No result for ''${state.query}''");
          }
        }
        if (state is SearchCoinFailure) {
          if (state.errorType == ErrorType.noInternetConnection) {
            return const NoInternet(
              icon: SvgIcon(icon: SvgIcons.noWifiLine),
              text: "No internet",
            );
          }
        }
        return Container();
      },
    );
  }

  ///When [SearchCoinInitial], [SearchCoinLoading], [SearchCoinFailure] or [SearchCoinLoaded] (with empty coin list or old request) is emitted
  BlocBuilder<SearchCoinBloc, SearchCoinState> buildBottom() {
    return BlocBuilder<SearchCoinBloc, SearchCoinState>(
      builder: (context, state) {
        if (state is SearchCoinFailure ||
            state is SearchCoinLoading ||
            state is SearchCoinInitial ||
            (state is SearchCoinLoaded && state.coinsList.isEmpty) ||
            (state is SearchCoinLoaded &&
                state.requestTime < lastSearchResult)) {
          //if there is old data from prev. search
          if (currentSearchResult.isNotEmpty) {
            return Column(
                children: List<SearchItem>.generate(
                    currentSearchResult.length,
                    (index) => SearchItem(
                      id: widget.coinList![index].id,
                        name: currentSearchResult[index].name,
                        symbol: currentSearchResult[index].symbol,
                        image: currentSearchResult[index].image,
                        rank: currentSearchResult[index].marketCapRank)));
          } else if (widget.coinList != null) {
            //Or coinList is not null
            return widget.coinList!.isNotEmpty
                ? Column(
                    children: List<SearchItem>.generate(
                        10,
                        (index) => SearchItem(
                          id: widget.coinList![index].id,
                            name: widget.coinList![index].name,
                            symbol: widget.coinList![index].symbol,
                            image: widget.coinList![index].image,
                            rank: widget.coinList![index].marketCapRank)))
                : Container();
          }
        }
        return Container();
      },
    );
  }
}

class NoInternet extends StatefulWidget {
  final Widget? icon;
  final String? text;
  final double? height;
  final Duration? duration;
  const NoInternet({
    Key? key,
    this.icon,
    this.text,
    this.height,
    this.duration,
  }) : super(key: key);

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  double _height = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _height = widget.height ?? 40;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: widget.duration ?? const Duration(milliseconds: 500),
        height: _height,
        color: AppColors.secondGrey.withOpacity(0.3),
        child: Center(
          child: SingleChildScrollView(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              widget.icon ?? Container(),
              const SizedBox(width: 10),
              Text(
                widget.text ?? "",
                style: const TextStyle(fontFamily: 'Inter'),
              )
            ]),
          ),
        ));
  }
}
