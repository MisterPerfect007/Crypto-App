import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_trends/injection_container.dart' as di;

import '../../../coinList/domain/entities/coin.dart';
import '../bloc/search_coin_bloc.dart';
import '../widgets/search_app_bar.dart';
import '../widgets/search_item.dart';
import '../widgets/search_item_shimmer.dart';

class Search extends StatelessWidget {
  final List<Coin>? coinList;
  const Search({Key? key, this.coinList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double sidePadding = width / 25;

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: ((context) => di.sl<SearchCoinBloc>())),
        ],
        child: Scaffold(
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
              child: Column(
                children: [
                  BlocBuilder<SearchCoinBloc, SearchCoinState>(
                    builder: (context, state) {
                      if (state is SearchCoinLoading) {
                        return const SearchItemShimmer();
                      }
                      return Container();
                    },
                  ),
                  const SearchItem(),
                  const SearchItem(),
                  const SearchItem(),
                ],
              ),
            ),
          ),
        ));
  }
}
