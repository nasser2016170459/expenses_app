import 'package:inovola/core/models/currency.dart';
import 'package:inovola/core/models/time_period.dart';

class HomeEvent {}

class LoadHomeData extends HomeEvent {}

class RefreshHomeData extends HomeEvent {
  final TimePeriod selectedTimePeriod;

  RefreshHomeData(this.selectedTimePeriod);
}

class LoadMoreItems extends HomeEvent {}

class ResetPagination extends HomeEvent {}

class ChangeCurrency extends HomeEvent {
  final Currency currency;

  ChangeCurrency(this.currency);
}
