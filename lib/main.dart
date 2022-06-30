import 'package:crypto_trends/features/coinInfo/presenter/page/coin_info.dart';
import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'package:crypto_trends/features/coinList/presenter/cubit/pagination_cubit.dart';
import 'package:crypto_trends/features/coinList/presenter/pages/coin_list_page.dart';
import 'package:crypto_trends/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/coinList/presenter/cubit/scrollposition_cubit.dart';
import 'features/coinList/presenter/cubit/sorting_cubit.dart';

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
      // themeMode: ThemeMode.light,
      home: MultiBlocProvider(
        // create: (context) => di.sl<CoinListBloc>(),
        providers: [
          BlocProvider(create: (context) => di.sl<CoinListBloc>()),
          BlocProvider(create: (context) => ScrollPositionCubit()),
          BlocProvider(create: (context) => SortingCubit()),
          BlocProvider(create: (context) => PaginationCubit()),
        ],
        child: CoinListPage(),
      ),
    );
  }
}
