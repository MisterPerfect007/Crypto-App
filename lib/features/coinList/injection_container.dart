part of '../../injection_container.dart';

Future<void> initCoinList() async {
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
}
