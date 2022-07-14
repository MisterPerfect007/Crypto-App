import 'package:crypto_trends/features/coinList/data/repository/get_coin_list_repository_implementation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/network_info.dart';
import 'features/coinInfo/data/datasources/coin_market_chart_remote_data_source.dart';
import 'features/coinInfo/data/repositories/get_coin_market_chart_repository_implementation.dart';
import 'features/coinInfo/domain/repository/get_coin_market_chart_repository.dart';
import 'features/coinInfo/domain/usescases/get_coin_market_chart.dart';
import 'features/coinInfo/presenter/bloc/coininfo_bloc.dart';
import 'features/coinList/data/datasources/coin_list_remote_data_source.dart';
import 'features/coinList/domain/repositories/get_coin_list_repository.dart';
import 'features/coinList/domain/usecases/get_coin_list.dart';
import 'features/coinList/presenter/bloc/coin_list_bloc.dart';

part 'features/coinInfo/injection_container.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //!Presenter
  //*Bloc
  sl.registerFactory(() => CoinListBloc(getRemoteCoinList: sl(), network: sl()));

  //!domain
  //*usecase
  sl.registerLazySingleton(() => GetRemoteCoinList(repository: sl()));

  sl.registerLazySingleton<CoinListRepository>(
      () => CoinListRepositoryImpl(remote: sl()));

  //!data
  sl.registerLazySingleton<CoinListRemoteDataSource>(
    () => CoinListRemoteDataSourceImpl(client: sl()));

  //!External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: InternetConnectionChecker()));
   //
  initCoinInfo();
}
