import 'package:crypto_trends/core/widgets/animation/custom_opacity_animation.dart';
import 'package:crypto_trends/core/widgets/favorite/favorite.dart';
import 'package:crypto_trends/errors/error_types.dart';
import 'package:crypto_trends/features/favorites/presenter/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_trends/injection_container.dart' as di;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/widgets/errors/error_message.dart';
import '../../../../ui/icons/svg_icons.dart';
import '../../../coinList/domain/entities/coin.dart';

import '../bloc/coin_infos/coin_infos_bloc.dart';
import '../widgets/body.dart';
import '../widgets/coin_info_app_bar.dart';

class CoinInfoPage extends StatelessWidget {
  const CoinInfoPage({Key? key, required this.coin, required this.id})
      : super(key: key);
  final Coin? coin;
  final String id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<CoinInfosBloc>()),
        BlocProvider(create: (context) => FavoriteBloc()),
        ],
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(
            size.width,
            50,
          ),
          child: const CustomOpacityAnimation(child: CoinInfoPageAppBar()),
        ),
        body: buildBody(),
      ),
    );
  }

  StatelessWidget buildBody() {
    if (coin != null) {
      return Body(coin: coin!);
    } else {
      return Builder(builder: (context) {
        //
        final theme = Theme.of(context);
        //
        /* if coin is null so make a call to the API */
        handleApiCall(context);
        return BlocBuilder<CoinInfosBloc, CoinInfosState>(
          builder: (context, state) {
            if (state is CoinInfosInitial || state is CoinInfosLoading) {
              return const CustomOpacityAnimation(
                  child: Center(
                      child: CircularProgressIndicator(strokeWidth: 3.0)));
            } else if (state is CoinInfosLoaded) {
              return Body(coin: state.coin);
            } else if (state is CoinInfosFailure) {
              //When no internet
              if (state.errorType == ErrorType.noInternetConnection) {
                return CustomErrorWidget(
                  msg: 'No internet',
                  icon: SvgIcons.noWifiLine,
                  onPressed: () async {
                    if (await InternetConnectionChecker().hasConnection) {
                      handleApiCall(context);
                    } else {
                      Fluttertoast.showToast(
                          msg: "You still Offline",
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: theme.primaryColor,
                          textColor: theme.scaffoldBackgroundColor);
                    }
                  },
                );
              } else {
                return CustomErrorWidget(
                  msg: 'Some went wrong on the back side',
                  icon: SvgIcons.badO,
                  onPressed: () {
                    handleApiCall(context);
                  },
                );
              }
            }
            return Container();
          },
        );
      });
    }
  }

  ///Should trigger the [CoinInfosGet] event if the state is not [CoinInfosLoaded]
  void handleApiCall(BuildContext context) {
    if (context.read<CoinInfosBloc>().state is! CoinInfosLoaded) {
      context.read<CoinInfosBloc>().add(CoinInfosGet(coinId: id));
    }
  }
}
