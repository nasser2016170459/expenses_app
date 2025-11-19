import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovola/core/app_logger.dart';
import 'package:inovola/core/handlers/api_calls_handler.dart';
import 'package:inovola/core/models/currency.dart';
import 'package:inovola/core/models/purchased_item_database.dart';
import 'package:inovola/core/services/exchange_rate_service.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeInitialState> with ApiCallsHandler {
  final _logger = AppLogger("HomeBloc");
  final _exchangeRateService = ExchangeRateService();
  static const int _pageSize = 10;

  double _usdToEgpRate = 47.17;

  HomeBloc() : super(HomeInitialState()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoadingState());

      await _fetchExchangeRates();

      final db = PurchasedItemDatabase.instance;
      final totalItems = await db.getItemsCount();
      final items = await db.getItemsPaginated(
        page: 0,
        pageSize: _pageSize,
      );

      final allItems = await db.getAllItems();
      final totalExpenses = allItems.fold<double>(
        0.0,
        (sum, item) => sum + item.price,
      );

      const income = 10000.0;
      final balance = income - totalExpenses;

      _logger.info("Loaded ${items.length} of $totalItems items");

      emit(HomeLoadedState(
        items: items,
        currentPage: 0,
        hasMoreData: items.length < totalItems,
        totalItems: totalItems,
        totalExpenses: totalExpenses,
        income: income,
        balance: balance,
        selectedCurrency: Currency.USD,
        exchangeRate: 1.0,
      ));
    });

    on<RefreshHomeData>((event, emit) async {
      if (state is HomeLoadedState) {
        emit(HomeLoadingState());

        final currentState = state as HomeLoadedState;
        final db = PurchasedItemDatabase.instance;
        final totalItems = await db.getItemsCount(period: event.selectedTimePeriod);
        final items = await db.getItemsPaginated(
          page: 0,
          pageSize: _pageSize,
          period: event.selectedTimePeriod,
        );

        final allItemsInPeriod = await db.getItemsByTimePeriod(event.selectedTimePeriod);
        final totalExpenses = allItemsInPeriod.fold<double>(
          0.0,
          (sum, item) => sum + item.price,
        );

        const income = 10000.0;
        final balance = income - totalExpenses;

        emit(HomeLoadedState(
          items: items,
          selectedTimePeriod: event.selectedTimePeriod,
          isFiltering: true,
          currentPage: 0,
          hasMoreData: items.length < totalItems,
          totalItems: totalItems,
          totalExpenses: totalExpenses,
          income: income,
          balance: balance,
          selectedCurrency: currentState.selectedCurrency,
          exchangeRate: currentState.exchangeRate,
        ));
      }
    });

    on<LoadMoreItems>((event, emit) async {
      if (state is HomeLoadedState) {
        final currentState = state as HomeLoadedState;

        if (currentState.items.length >= currentState.totalItems) {
          _logger.info("All items already loaded");
          return;
        }

        if (!currentState.hasMoreData || currentState.isLoadingMore) {
          return;
        }

        emit(HomeLoadedState(
          items: currentState.items,
          selectedTimePeriod: currentState.selectedTimePeriod,
          currentPage: currentState.currentPage,
          hasMoreData: currentState.hasMoreData,
          isLoadingMore: true,
          totalItems: currentState.totalItems,
          totalExpenses: currentState.totalExpenses,
          income: currentState.income,
          balance: currentState.balance,
          selectedCurrency: currentState.selectedCurrency,
          exchangeRate: currentState.exchangeRate,
        ));

        final db = PurchasedItemDatabase.instance;
        final nextPage = currentState.currentPage + 1;
        final newItems = await db.getItemsPaginated(
          page: nextPage,
          pageSize: _pageSize,
          period: currentState.selectedTimePeriod,
        );

        final allItems = [...currentState.items, ...newItems];

        _logger.info("Loaded page $nextPage, total items: ${allItems.length}/${currentState.totalItems}");

        final hasMore = allItems.length < currentState.totalItems && newItems.isNotEmpty;

        emit(HomeLoadedState(
          items: allItems,
          selectedTimePeriod: currentState.selectedTimePeriod,
          currentPage: nextPage,
          hasMoreData: hasMore,
          isLoadingMore: false,
          totalItems: currentState.totalItems,
          totalExpenses: currentState.totalExpenses,
          income: currentState.income,
          balance: currentState.balance,
          selectedCurrency: currentState.selectedCurrency,
          exchangeRate: currentState.exchangeRate,
        ));
      }
    });

    on<ChangeCurrency>((event, emit) {
      if (state is HomeLoadedState) {
        final currentState = state as HomeLoadedState;

        final newRate = event.currency == Currency.USD ? 1.0 : _usdToEgpRate;

        emit(HomeLoadedState(
          items: currentState.items,
          selectedTimePeriod: currentState.selectedTimePeriod,
          isFiltering: currentState.isFiltering,
          currentPage: currentState.currentPage,
          hasMoreData: currentState.hasMoreData,
          isLoadingMore: currentState.isLoadingMore,
          totalItems: currentState.totalItems,
          totalExpenses: currentState.totalExpenses,
          income: currentState.income,
          balance: currentState.balance,
          selectedCurrency: event.currency,
          exchangeRate: newRate,
        ));
      }
    });
  }

  Future<void> _fetchExchangeRates() async {
    _logger.info("Fetching exchange rates");
    final result = await handleApiCall(() => _exchangeRateService.getExchangeRates());

    if (result.isSucceeded) {
      _logger.info("Exchange rates fetched successfully");
      final egpRate = result.resultData?.rates['EGP'];
      if (egpRate != null) {
        _usdToEgpRate = egpRate;
        _logger.info("USD to EGP rate: $_usdToEgpRate");
      }
    } else {
      _logger.error("Failed to fetch exchange rates");
    }
  }
}
