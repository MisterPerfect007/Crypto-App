part of 'coininfo_bloc.dart';

abstract class CoinInfoEvent extends Equatable {
  const CoinInfoEvent();

  @override
  List<Object> get props => [];
}

class GetCoinInfo extends CoinInfoEvent {
  final String id;
  final String days;
  final bool dailyInterval;

  const GetCoinInfo({
    required this.id,
    required this.days,
    required this.dailyInterval,
  });

  @override
  List<Object> get props => [id, days, dailyInterval];
}
