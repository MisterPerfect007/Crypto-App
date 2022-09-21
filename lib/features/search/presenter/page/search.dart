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
import '../widgets/no_internet.dart';
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
        //!
        //! SearchCoinLoading
        //!
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
        //!
        //! SearchCoinLoaded
        //!
        if (state is SearchCoinLoaded) {
          final coinsList = state.coinsList;
          final requestTime = state.requestTime;
          if (coinsList.isNotEmpty &&
              (requestTime >=
                  lastSearchResult) /*//! should show the latest result */) {
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
                  ),
                ),
              ),
            );
          } else if (coinsList.isEmpty) {
            return NoInternet(text: "No result for ''${state.query}''");
          }
        }
        //!
        //! SearchCoinFailure
        //!
        if (state is SearchCoinFailure) {
          if (state.errorType == ErrorType.noInternetConnection) {
            return const NoInternet(
              icon: SvgIcon(icon: SvgIcons.noWifiLine),
              text: "No internet",
            );
          } else {
            return const NoInternet(
              icon: SvgIcon(icon: SvgIcons.badO),
              text: "Something went wrong",
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
          //!if there is old data from prev. search
          if (currentSearchResult.isNotEmpty) {
            return Column(
                children: List<SearchItem>.generate(
                    currentSearchResult.length,
                    (index) => SearchItem(
                        id: currentSearchResult[index].id,
                        name: currentSearchResult[index].name,
                        symbol: currentSearchResult[index].symbol,
                        image: currentSearchResult[index].image,
                        rank: currentSearchResult[index].marketCapRank)));
          } else if (widget.coinList != null) {
            //!Or coinList is not null
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
