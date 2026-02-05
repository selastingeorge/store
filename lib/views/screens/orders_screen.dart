import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:store/core/fonts/store_glyphs.dart';
import 'package:store/core/types/order_status.dart';
import 'package:store/notifier/order_notifier.dart';
import 'package:store/views/placeholders/order_card_placeholder.dart';
import 'package:store/views/widgets/order_item_card.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> with AutomaticKeepAliveClientMixin {
  String _search = '';
  String? _selectedStatus = 'All Status';

  Timer? _debounce;

  late final _pagingController = PagingController<int, Map<String, dynamic>>(
    getNextPageKey: (state) {
      return state.lastPageIsEmpty ? null : state.nextIntPageKey;
    },
    fetchPage: (pageKey) async {
      final notifier = ref.read(orderProvider.notifier);
      return notifier.fetchPage(pageKey, query: _search, status: _selectedStatus);
    },
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: PagingListener(
          controller: _pagingController,
          builder: (context, state, fetchNextPage) => CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: TextField(
                    style: TextStyle(fontSize: 14),
                    onChanged: (value) {
                      if (_debounce?.isActive ?? false) _debounce!.cancel();
                      _debounce = Timer(const Duration(milliseconds: 500), () {
                        _search = value;
                        _pagingController.refresh();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Search orders...",
                      hintStyle: const TextStyle(fontSize: 14),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 3),
                        child: Icon(StoreGlyphs.searchMedium, size: 18, color: Color(0xFF64748b)),
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFe2e8f0)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFe2e8f0)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFe2e8f0)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: OrderStatus.values.map((status) {
                        final isSelected = _selectedStatus == status.label;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            color: WidgetStateProperty.resolveWith((states) {
                              if (states.contains(WidgetState.selected)) {
                                return OrderStatus.getStatusBackgroundColor(status);
                              }
                              return Colors.white;
                            }),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            label: Text(
                              status.label,
                              style: TextStyle(
                                color: isSelected
                                    ? OrderStatus.getStatusForegroundColor(status)
                                    : colorScheme.onSurfaceVariant,
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (_) {
                              setState(() {
                                _selectedStatus = status.label;
                              });
                              _pagingController.refresh();
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 10)),
              PagedSliverList(
                state: state,
                fetchNextPage: fetchNextPage,
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, order, index) {
                    return Column(
                      children: [
                        OrderItemCard(
                          order: order as Map<String, dynamic>,
                          onTap: () {
                            context.push("/view-order", extra: order);
                          },
                        ),
                        SizedBox(height: 15),
                      ],
                    );
                  },
                  noItemsFoundIndicatorBuilder: (_) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 250),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(child: Icon(StoreGlyphs.ordersMedium)),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "No Orders found",
                              style: TextStyle(fontSize: 18, fontVariations: [FontVariation('wght', 600)]),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "No orders found matching this criteria, please try again",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  newPageProgressIndicatorBuilder: (_) => OrderCardPlaceholder(),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 15)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
