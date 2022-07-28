part of '../../injection_container.dart';

Future<void> initHome() async {
  //!Presenter
    //*Bloc
    sl.registerFactory(() => TrendingCoinsBloc(getCoinList: sl(), networkInfo: sl(), trendingCoinSource: sl(), ));


    //!data
    sl.registerLazySingleton(
      () => TrendingCoinRemoteDataSource(client: sl()));
}
