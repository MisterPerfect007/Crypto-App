part of '../../injection_container.dart';



Future<void> initCoinInfo() async {
  //!Presenter
  //*Bloc
  sl.registerFactory(() => CoinInfoBloc(network: sl(), usecase: sl()));
  sl.registerFactory(() => CoinInfosBloc(network: sl(),  getRemoteCoinList: sl()));

  //!domain
  //*usecase
  sl.registerLazySingleton(() => GetCoinMarketChart(repository: sl()));

  sl.registerLazySingleton<GetCoinMarketChartRepository>(
      () => GetCoinMarketChartRepositoryImpl(remote: sl()));

  //!data
  sl.registerLazySingleton(
    () => CoinMarketChartRemoteDataSourceImpl(client: sl()));
}
