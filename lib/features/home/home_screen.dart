import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovola/core/components/default_error_widget.dart';
import 'package:inovola/core/components/shimmer_loading_list.dart';
import 'package:inovola/core/models/currency.dart';
import 'package:inovola/core/models/time_period.dart';
import 'package:inovola/features/home/bloc/home_bloc.dart';
import 'package:inovola/features/home/bloc/home_event.dart';
import 'package:inovola/features/home/bloc/home_state.dart';
import 'package:inovola/features/home/components/balance_card.dart';
import 'package:inovola/features/home/components/recent_expense_item_widget.dart';
import 'package:inovola/features/home/components/welcome_card.dart';
import 'package:inovola/theme/app_colors.dart';
import 'package:inovola/theme/app_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    return BlocConsumer<HomeBloc, HomeInitialState>(
      listener: (context, state) {
        if (state is HomeLoadedState && state.isFiltering) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.blue.withOpacity(0.9),
              content: Text(
                'Filtered by ${state.selectedTimePeriod.title}\n items loaded: ${state.items.length}',
                style: AppStyles.labelSmall.primary,
              ),
              duration: const Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is HomeLoadedState) {
          if (state.items.isEmpty) {
            return const HomeEmptyWidget();
          }
          return HomeScreenLoadedWidget(
            state: state,
            onTimePeriodChanged: (option) => homeBloc.add(RefreshHomeData(option)),
          );
        }
        if (state is HomeLoadingState) {
          return const HomeLoadingWidget();
        }
        if (state is HomeErrorState) {
          return HomeErrorWidget(
            errorMessage: state.errorMessage!,
            onRetry: () {},
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class HomeErrorWidget extends StatelessWidget {
  const HomeErrorWidget({
    required this.errorMessage,
    required this.onRetry,
    super.key,
  });

  final String errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultErrorWidget(
        errorMessage: errorMessage,
        onRetry: () => onRetry(),
      ),
    );
  }
}

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
      child: ShimmerLoadingList(itemCount: 10, itemHeight: 50),
    );
  }
}

class HomeEmptyWidget extends StatelessWidget {
  const HomeEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("No Items, start adding some!", style: AppStyles.labelMedium),
    );
  }
}

class HomeScreenLoadedWidget extends StatefulWidget {
  const HomeScreenLoadedWidget({super.key, required this.state, required this.onTimePeriodChanged});

  final HomeLoadedState state;
  final Function(TimePeriod) onTimePeriodChanged;

  @override
  State<HomeScreenLoadedWidget> createState() => _HomeScreenLoadedWidgetState();
}

class _HomeScreenLoadedWidgetState extends State<HomeScreenLoadedWidget> {
  final ScrollController _scrollController = ScrollController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && widget.state.hasMoreData && !widget.state.isLoadingMore) {
      _debounceTimer?.cancel();

      _debounceTimer = Timer(const Duration(milliseconds: 300), () {
        if (mounted && _isBottom && widget.state.hasMoreData && !widget.state.isLoadingMore) {
          context.read<HomeBloc>().add(LoadMoreItems());
        }
      });
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              WelcomeCardWidget(
                title: "Good Morning",
                subtitle: "Nasser Abdullah",
                imageUrl:
                    "https://lh3.googleusercontent.com/a/ACg8ocIftOKfAViGuKrzvoedke8YZOTvNNnhUE4DDck9fAPTZHY6LAs=s288-c-no",
                timePeriods: widget.state.timePeriods,
                selectedTimePeriod: widget.state.selectedTimePeriod,
                onTimePeriodChanged: (option) => widget.onTimePeriodChanged(option),
              ),
              Positioned(
                bottom: -70,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BalanceCard(
                    balance: widget.state.displayedBalance,
                    expenses: widget.state.displayedExpenses,
                    income: widget.state.displayedIncome,
                    selectedCurrency: widget.state.selectedCurrency,
                    onCurrencyTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Select Currency', style: AppStyles.labelLarge),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: Currency.values.map((currency) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text('${currency.code} (${currency.symbol})', style: AppStyles.labelMedium),
                                onTap: () {
                                  context.read<HomeBloc>().add(ChangeCurrency(currency));
                                  Navigator.pop(context);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
        SliverToBoxAdapter(
          child: ListTile(
            leading: Text("Recent Expenses", style: AppStyles.labelLarge),
            trailing: Text("see all", style: AppStyles.paragraphSmall),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, i) {
              if (i >= widget.state.items.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.blue),
                  ),
                );
              }
              return RecentExpenseItemWidget(
                purchasedItem: widget.state.items[i],
              );
            },
            childCount: widget.state.items.length + (widget.state.hasMoreData ? 1 : 0),
          ),
        ),
        if (!widget.state.hasMoreData && widget.state.items.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'No more items',
                style: AppStyles.paragraphSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
