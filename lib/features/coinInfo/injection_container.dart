part of '../../injection_container.dart';



Future<void> initCoinInfo() async {
  //!Presenter
  //*Bloc
  sl.registerFactory(() => CoinInfoBloc(network: sl(), usecase: sl()));

  //!domain
  //*usecase
  sl.registerLazySingleton(() => GetCoinMarketChart(repository: sl()));

  sl.registerLazySingleton<GetCoinMarketChartRepository>(
      () => GetCoinMarketChartRepositoryImpl(remote: sl()));

  //!data
  sl.registerLazySingleton(
    () => CoinMarketChartRemoteDataSourceImpl(client: sl()));

  //!External
  // sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => NetworkInfoImpl(internetConnectionChecker: InternetConnectionChecker()));
}
