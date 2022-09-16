import 'package:crypto_trends/injection_container.dart' as di;
import 'package:crypto_trends/root/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'features/coinList/presenter/cubit/pagination_cubit.dart';
import 'features/coinList/presenter/cubit/scrollposition_cubit.dart';
import 'features/coinList/presenter/cubit/sorting_cubit.dart';
import 'features/home/presenter/bloc/top10/top_10_bloc.dart';
import 'features/home/presenter/bloc/trending_coin/trending_coin_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/search/data/datasources/search_item_data_source.dart';

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // colorScheme: ColorScheme.fromSwatch(accentColor: Colors.red)
      ),
      // themeMode: ThemeMode.dark,
      home: MultiBlocProvider(
        providers: [
          //HOMPAGE
          BlocProvider(create: ((context) => di.sl<TrendingCoinsBloc>())),
          BlocProvider(create: ((context) => di.sl<Top10Bloc>())),
          //
          BlocProvider(create: (context) => di.sl<CoinListBloc>()),
          BlocProvider(create: (context) => ScrollPositionCubit()),
          BlocProvider(create: (context) => SortingCubit()),
          BlocProvider(create: (context) => PaginationCubit()),
          
        ],
        child: const Root(),
    ));
  }
}
