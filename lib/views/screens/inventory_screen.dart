import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:store/core/fonts/store_glyphs.dart';
import 'package:store/core/types/asset_status.dart';
import 'package:store/core/utils/string_utils.dart';
import 'package:store/notifier/inventory_notifier.dart';
import 'package:store/providers/inventory_provider.dart';
import 'package:store/views/placeholders/filter_chip_placeholder.dart';
import 'package:store/views/placeholders/inventory_card_placeholder.dart';
import 'package:store/views/widgets/inventory_item_card.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> with AutomaticKeepAliveClientMixin{
  String _search = '';
  String? _selectedCategory = 'all';
  String? _selectedStatus = 'All Status';

  Timer? _debounce;

  late final _pagingController = PagingController<int, Map<String, dynamic>>(
    getNextPageKey: (state) {
      return state.lastPageIsEmpty ? null : state.nextIntPageKey;
    },
    fetchPage: (pageKey) async {
      final notifier = ref.read(inventoryProvider.notifier);
      return notifier.fetchPage(
        pageKey,
        query: _search,
        category: _selectedCategory == 'all' ? null : _selectedCategory,
        status: _selectedStatus == 'All Status' ? null : _selectedStatus,
      );
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
                      hintText: "Search total assets...",
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
                      children: AssetStatus.values.map((status) {
                        final isSelected = _selectedStatus == status.label;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            color: WidgetStateProperty.resolveWith((states) {
                              if (states.contains(WidgetState.selected)) {
                                return AssetStatus.getStatusBackgroundColor(status);
                              }
                              return Colors.white;
                            }),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            label: Text(
                              status.label,
                              style: TextStyle(
                                color: isSelected
                                    ? AssetStatus.getStatusForegroundColor(status)
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

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ref
                      .watch(inventoryCategoriesProvider)
                      .when(
                        data: (categories) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: categories.map((category) {
                                final isSelected = _selectedCategory == category["name"];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    label: Text(StringUtils.toPascalCase(category["name"])),
                                    selected: isSelected,
                                    onSelected: (_) {
                                      setState(() {
                                        _selectedCategory = category["name"];
                                      });
                                      _pagingController.refresh();
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        },
                        error: (e, s) => Text("$e"),
                        loading: () => FilterChipPlaceholder(count: 6),
                      ),
                ),
              ),

              PagedSliverGrid<int, Map<String, dynamic>>(
                state: state,
                fetchNextPage: fetchNextPage,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 220,
                  mainAxisExtent: 290,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, asset, index) => InventoryItemCard(
                    asset: asset,
                    onTap: () {
                      context.push("/view-asset", extra: asset);
                    },
                  ),
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
                              child: Center(child: Icon(StoreGlyphs.packageOpenMedium)),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "No Assets found",
                              style: TextStyle(fontSize: 18, fontVariations: [FontVariation('wght', 600)]),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "No Assets found matching this criteria, please try again",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  newPageProgressIndicatorBuilder: (_) =>
                      const SizedBox(width: 200, child: InventoryCardPlaceholder()),
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
