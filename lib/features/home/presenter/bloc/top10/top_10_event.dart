part of 'top_10_bloc.dart';

abstract class Top10Event extends Equatable {
  const Top10Event();

  @override
  List<Object> get props => [];
}

class GetTop10Coins extends Top10Event {
  final int perPage;
  final int page;
  const GetTop10Coins({required this.page, required this.perPage});
}

class RefreshTop10Coins extends Top10Event {
  final int perPage;
  final int page;
  const RefreshTop10Coins({required this.page, required this.perPage});
}
