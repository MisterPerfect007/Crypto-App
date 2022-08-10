part of 'top_10_bloc.dart';

abstract class Top10State extends Equatable {
  const Top10State();
  
  @override
  List<Object> get props => [];
}

class Top10Initial extends Top10State {}

class Top10Loading extends Top10State {}

class Top10Loaded extends Top10State {
  final List<Coin> coinList;
  const Top10Loaded({required this.coinList});

  @override
  List<Object> get props => [coinList];
}

class Top10Failure extends Top10State {
  final ErrorType errorType;
  const Top10Failure(this.errorType);

  @override
  List<Object> get props => [errorType];
}