import 'package:crypto_trends/features/coinList/data/repository/get_coin_list_repository_implementation.dart';
import 'package:crypto_trends/services/firebase/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/localStorage/local_storage_key_value.dart';
import 'core/network/network_info.dart';
import 'features/coinInfo/data/datasources/coin_market_chart_remote_data_source.dart';
import 'features/coinInfo/data/repositories/get_coin_market_chart_repository_implementation.dart';
import 'features/coinInfo/domain/repository/get_coin_market_chart_repository.dart';
import 'features/coinInfo/domain/usescases/get_coin_market_chart.dart';
import 'features/coinInfo/presenter/bloc/coin_infos/coin_infos_bloc.dart';
import 'features/coinInfo/presenter/bloc/coinChartInfo/coininfo_bloc.dart';
import 'features/coinList/data/datasources/coin_list_remote_data_source.dart';
import 'features/coinList/domain/repositories/get_coin_list_repository.dart';
import 'features/coinList/domain/usecases/get_coin_list.dart';
import 'features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'features/home/data/trending_coin_remote_data_source.dart';
import 'features/home/presenter/bloc/top10/top_10_bloc.dart';
import 'features/home/presenter/bloc/trending_coin/trending_coin_bloc.dart';
import 'features/search/data/datasources/search_item_data_source.dart';
import 'features/search/data/repository/get_search_item_impl.dart';
import 'features/search/domain/repository/get_search_items.dart';
import 'features/search/domain/usecases/get_search_coin.dart';
import 'features/search/presenter/bloc/search_coin_bloc.dart';
import 'features/settings/utils/get_currency.dart';

part 'features/coinInfo/injection_container.dart';
part 'features/coinList/injection_container.dart';
part 'features/home/injection_container.dart';
part 'features/search/injection_container.dart';
part 'features/settings/injection_container.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  
  //!External
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => CurrencyStorage());
  
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: InternetConnectionChecker()));

  //!firebase auth
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FireAuth(sl()));
   
  await initCoinInfo();
  await initCoinList();
  await initHome();
  await initSearchCoin();
  await initSettings();
}
