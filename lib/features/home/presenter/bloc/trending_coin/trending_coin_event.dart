part of 'trending_coin_bloc.dart';

abstract class TrendingCoinsEvent extends Equatable {
  const TrendingCoinsEvent();

  @override
  List<Object> get props => [];
}

class GetTrendingCoins extends TrendingCoinsEvent{}

class RefreshTrendingCoins extends TrendingCoinsEvent{}

