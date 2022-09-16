import 'package:crypto_trends/errors/error_types.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:crypto_trends/ui/icons/svg-icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../errors/error_types.dart';
import '../../../coinList/domain/entities/coin.dart';
import '../../domain/entity/search_coin.dart';
import '../bloc/search_coin_bloc.dart';
import '../widgets/search_app_bar.dart';
import '../widgets/search_item.dart';
import '../widgets/search_item_shimmer.dart';

class Search extends StatefulWidget {
  final List<Coin>? coinList;
  const Search({Key? key, this.coinList}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<SearchCoin> currentSearchResult = [];

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
        child: SearchAppBar(),
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<SearchCoinBloc, SearchCoinState>(
                builder: (context, state) {
                  // print(state);
                  if (state is SearchCoinLoading) {
                    return const SearchItemShimmer();
                  }
                  if (state is SearchCoinLoaded) {
                    final coinsList = state.coinsList;
                    currentSearchResult = coinsList;
                    // print(coinsList.first);
                    if(coinsList.isNotEmpty){
                      return Column(
                          children: List<SearchItem>.generate(
                              coinsList.length,
                              (index) => SearchItem(
                                  name: coinsList[index].name,
                                  symbol: coinsList[index].symbol,
                                  image: coinsList[index].image,
                                  rank: coinsList[index].marketCapRank)));
                    }else {
                      return const NoInternet(text: "No result");
                    }
                  }
                  if (state is SearchCoinFailure) {
                    if (state.errorType == ErrorType.noInternetConnection) {
                      return const NoInternet(icon: SvgIcon(icon: SvgIcons.noWifiLine), text: "No internet",);
                    }
                  }
                  return Container();
                },
              ),
              BlocBuilder<SearchCoinBloc, SearchCoinState>(
                builder: (context, state) {
                  if (state is! SearchCoinLoaded) {
                    //if there is old data from prev. search
                    if (currentSearchResult.isNotEmpty) {
                      return Column(
                          children: List<SearchItem>.generate(
                              currentSearchResult.length,
                              (index) => SearchItem(
                                  name: currentSearchResult[index].name,
                                  symbol: currentSearchResult[index].symbol,
                                  image: currentSearchResult[index].image,
                                  rank: currentSearchResult[index]
                                      .marketCapRank)));
                    } else if (widget.coinList != null) {
                      //Or coinList is not null
                      return widget.coinList!.isNotEmpty
                          ? Column(
                              children: List<SearchItem>.generate(
                                  7,
                                  (index) => SearchItem(
                                      name: widget.coinList![index].name,
                                      symbol: widget.coinList![index].symbol,
                                      image: widget.coinList![index].image,
                                      rank: widget
                                          .coinList![index].marketCapRank)))
                          : Container();
                    }
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NoInternet extends StatefulWidget {
  final Widget? icon;
  final String text;
  const NoInternet({
    Key? key, this.icon, required this.text,
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
        _height = 40;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: _height,
        color: AppColors.secondGrey.withOpacity(0.3),
        child: Center(
          child: SingleChildScrollView(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  widget.icon ?? Container(),
                  const SizedBox(
                    width: 10
                  ),
                  Text(
                    widget.text,
                    style: const TextStyle(
                      fontFamily: 'Inter'
                    ),
                  )
                ]),
          ),
        ));
  }
}
