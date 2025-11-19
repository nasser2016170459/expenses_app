import 'package:flutter/material.dart';
import 'package:inovola/core/models/currency.dart';
import 'package:inovola/core/models/purchased_item.dart';
import 'package:inovola/core/models/time_period.dart';

class HomeInitialState {}

class HomeLoadingState extends HomeInitialState {}

class HomeErrorState extends HomeInitialState {
  final String? errorMessage;
  final VoidCallback? onRetry;
  HomeErrorState({this.errorMessage, this.onRetry});
}

class HomeLoadedState extends HomeInitialState {
  final List<PurchasedItem> items;
  final timePeriods = <TimePeriod>[...TimePeriod.values];
  final TimePeriod selectedTimePeriod;
  final bool isFiltering;
  final int currentPage;
  final bool hasMoreData;
  final bool isLoadingMore;
  final int totalItems;
  final double totalExpenses;
  final double income;
  final double balance;
  final Currency selectedCurrency;
  final double exchangeRate;

  HomeLoadedState({
    required this.items,
    TimePeriod? selectedTimePeriod,
    this.isFiltering = false,
    this.currentPage = 0,
    this.hasMoreData = true,
    this.isLoadingMore = false,
    this.totalItems = 0,
    this.totalExpenses = 0.0,
    this.income = 10000.0,
    this.balance = 10000.0,
    this.selectedCurrency = Currency.USD,
    this.exchangeRate = 1.0,
  }) : selectedTimePeriod = selectedTimePeriod ?? TimePeriod.values.first;

  double get displayedIncome => income * exchangeRate;
  double get displayedExpenses => totalExpenses * exchangeRate;
  double get displayedBalance => balance * exchangeRate;
}