import 'package:crypto_trends/features/coinList/data/repository/get_coin_list_repository_implementation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/coinList/data/datasources/coin_list_remote_data_source.dart';
import 'features/coinList/domain/repositories/get_coin_list_repository.dart';
import 'features/coinList/domain/usecases/get_coin_list.dart';
import 'features/coinList/presenter/bloc/coin_list_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //!Presenter
  //*Bloc
  sl.registerFactory(() => CoinListBloc(getRemoteCoinList: sl()));

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
}
