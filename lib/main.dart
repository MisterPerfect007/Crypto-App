import 'package:crypto_trends/features/home/presenter/page/home_page.dart';
import 'package:crypto_trends/injection_container.dart' as di;
import 'package:crypto_trends/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'features/coinList/presenter/cubit/pagination_cubit.dart';
import 'features/coinList/presenter/cubit/scrollposition_cubit.dart';
import 'features/coinList/presenter/cubit/sorting_cubit.dart';
import 'features/home/presenter/bloc/trending_coin/trending_coin_bloc.dart';

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final double displayWidth = MediaQuery.of(context).size.width;
    // final double displayHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // colorScheme: ColorScheme.fromSwatch(accentColor: Colors.red)
      ),
      // themeMode: ThemeMode.light,
      home: MultiBlocProvider(
        providers: [
          //HOMPAGE
          BlocProvider(create: ((context) => di.sl<TrendingCoinsBloc>())),
          //
          BlocProvider(create: (context) => di.sl<CoinListBloc>()),
          BlocProvider(create: (context) => ScrollPositionCubit()),
          BlocProvider(create: (context) => SortingCubit()),
          BlocProvider(create: (context) => PaginationCubit()),
          
        ],
        child: const Root(),
      // MultiBlocProvider(providers: [
      //   BlocProvider(create: ((context) => TimeSlotCubit()))
      // ],
      // child: const CoinInfoPage(),),
      // // MultiBlocProvider(
      // //   providers: [
      // //     BlocProvider(create: (context) => di.sl<CoinListBloc>()),
      // //     BlocProvider(create: (context) => ScrollPositionCubit()),
      // //     BlocProvider(create: (context) => SortingCubit()),
      // //     BlocProvider(create: (context) => PaginationCubit()),
      // //   ],
      // //   child: const CoinListPage(),
      // // ),
    ));
  }
}
