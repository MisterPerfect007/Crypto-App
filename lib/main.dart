import 'package:crypto_trends/injection_container.dart' as di;
import 'package:crypto_trends/root/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'features/coinList/presenter/cubit/pagination_cubit.dart';
import 'features/coinList/presenter/cubit/scrollposition_cubit.dart';
import 'features/coinList/presenter/cubit/sorting_cubit.dart';
import 'features/home/presenter/bloc/top10/top_10_bloc.dart';
import 'features/home/presenter/bloc/trending_coin/trending_coin_bloc.dart';
import 'features/search/presenter/bloc/search_coin_bloc.dart';
import 'features/theme/cubit/app_theme_cubit.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await di.init();
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppThemeCubit(),
      child: BlocBuilder<AppThemeCubit, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Crypto Trends',
            theme: state,
            // themeMode: ThemeMode.dark,
            home: MultiBlocProvider(
              providers: [
                //HOMPAGE
                BlocProvider(create: ((context) => di.sl<TrendingCoinsBloc>())),
                BlocProvider(create: ((context) => di.sl<Top10Bloc>())),
                //
                BlocProvider(create: (context) => di.sl<CoinListBloc>()),
                BlocProvider(create: (context) => di.sl<SearchCoinBloc>()),
                BlocProvider(create: (context) => ScrollPositionCubit()),
                BlocProvider(create: (context) => SortingCubit()),
                BlocProvider(create: (context) => PaginationCubit()),
              ],
              child: const Root(),
            ),
          );
        },
      ),
    );
  }
}
