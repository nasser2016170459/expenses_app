import 'package:flutter/material.dart';
import 'package:inovola/core/components/shimmer_loading_widget.dart';

class ShimmerLoadingList extends StatelessWidget {
  const ShimmerLoadingList({
    super.key,
    required this.itemCount,
    this.scrollController,
    this.itemHeight,
    this.itemWidth,
  });

  final int itemCount;
  final double? itemHeight;
  final double? itemWidth;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemCount: itemCount,
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, i) => ShimmerLoadingWidget(
        width: itemWidth ?? MediaQuery.of(context).size.width,
        height: itemHeight ?? 80,
      ),
    );
  }
}
