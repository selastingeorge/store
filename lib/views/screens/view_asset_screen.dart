import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:store/config.dart';
import 'package:store/core/fonts/store_glyphs.dart';
import 'package:store/providers/inventory_provider.dart';
import 'package:store/views/widgets/elevated_card.dart';
import 'package:store/views/widgets/image_carousel.dart';
import 'package:store/views/widgets/timeline_item.dart';
import 'package:store/views/widgets/title_bar.dart';

class ViewAssetScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> asset;
  const ViewAssetScreen({super.key, required this.asset});

  @override
  ConsumerState<ViewAssetScreen> createState() => _ViewAssetScreenState();
}

class _ViewAssetScreenState extends ConsumerState<ViewAssetScreen> with SingleTickerProviderStateMixin {
  String total = "\$0";
  final List<String> images = [];
  String id = "#24";
  bool liked = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    if (widget.asset["custom_asset_image"] != null) {
      images.add("${Config.apiUrl}/${widget.asset["custom_asset_image"]}");
    }

    if (widget.asset["image"] != null) {
      images.add("${Config.apiUrl}/${widget.asset["image"]}");
    }

    final formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);
    total = formatter.format(widget.asset["total_asset_cost"]);

    id = widget.asset["name"].length > 3
        ? widget.asset["name"].substring(widget.asset["name"].length - 3)
        : widget.asset["name"];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double ratingFromTitle(String title, {double min = 4, double max = 5}) {
    final hash = title.hashCode;
    final normalized = (hash & 0x7fffffff) / 0x7fffffff;
    final rating = min + (max - min) * normalized;
    return double.parse(rating.toStringAsFixed(1));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleBar(
        showBack: true,
        title: "Asset Details",
        subtitle: "ID: $id",
        showUserPicker: false,
        showLogout: false,
        height: 65,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                liked = !liked;
              });
            },
            icon: Icon(liked ? StoreGlyphs.heartFilledMedium : StoreGlyphs.heartMedium),
            iconSize: 20,
            color: liked ? Colors.red : colorScheme.onSurfaceVariant,
          ),
        ],
        onBackPressed: () {
          context.pop();
        },
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 400,
              child: (images.isNotEmpty)
                  ? ImageCarousel(
                      images: images,
                      showIndicator: true,
                      borderRadius: BorderRadius.zero,
                      enlargeCenterImage: false,
                      itemPadding: EdgeInsets.zero,
                    )
                  : Image.asset("assets/images/placeholder-image.png", height: 400, fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.asset["item_name"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontVariations: [FontVariation('wght', 800)],
                      color: colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 15),
                  GridView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 3.8,
                    ),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Item Code",
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                              fontVariations: const [FontVariation('wght', 400)],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(StoreGlyphs.barcodeMedium, size: 16, color: colorScheme.onSurfaceVariant),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  "#${widget.asset["name"]}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontVariations: [FontVariation('wght', 500)],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Item Group",
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                              fontVariations: const [FontVariation('wght', 400)],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Expanded(
                            child: Text(
                              widget.asset["asset_category"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 14,
                                fontVariations: [FontVariation('wght', 500)],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Brand",
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                              fontVariations: const [FontVariation('wght', 400)],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Expanded(
                            child: Text(
                              "Not Specified",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 14,
                                fontVariations: [FontVariation('wght', 500)],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Manufacturer",
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                              fontVariations: const [FontVariation('wght', 400)],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Expanded(
                            child: Text(
                              "Unknown",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 14,
                                fontVariations: [FontVariation('wght', 500)],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: Divider(color: colorScheme.onSurfaceVariant.withAlpha(10), height: 1)),
          SliverPersistentHeader(
            pinned: false,
            delegate: _StickyTabBarDelegate(
              TabBar(
                controller: _tabController,
                isScrollable: false,
                indicatorWeight: 2,
                labelColor: colorScheme.primary,
                unselectedLabelColor: colorScheme.onSurfaceVariant,
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'Details'),
                  Tab(text: 'Linked Assets'),
                  Tab(text: 'History'),
                ],
              ),
            ),
          ),
        ],
        body: Container(
          color: Color(0xFFf8f2ef),
          child: TabBarView(
            controller: _tabController,
            children: [
              // Wrap content in SingleChildScrollView
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedCard(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Value",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colorScheme.onSurfaceVariant,
                                    fontVariations: [FontVariation('wght', 500)],
                                  ),
                                ),
                                Text(
                                  total,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontVariations: [FontVariation('wght', 900)],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Color(0xFFe7ebee),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.star_rounded, size: 20, color: Color(0xFFffb900)),
                                  SizedBox(width: 5),
                                  Text(
                                    ratingFromTitle(widget.asset["item_name"]).toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontVariations: [FontVariation('wght', 900)],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedCard(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(StoreGlyphs.infoMedium, size: 16, color: Color(0xFF314158)),
                                SizedBox(width: 5),
                                Text(
                                  "Description",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontVariations: [FontVariation('wght', 500)],
                                    color: Color(0xFF314158),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.asset["custom_asset_details"] ?? "",
                              style: TextStyle(color: Color(0xFF45556c)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedCard(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(StoreGlyphs.mapPinMedium, size: 16, color: Color(0xFF314158)),
                                SizedBox(width: 5),
                                Text(
                                  "Store",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontVariations: [FontVariation('wght', 500)],
                                    color: Color(0xFF314158),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(widget.asset["location"] ?? "", style: TextStyle(color: Color(0xFF45556c))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Other tabs
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 15,
                    children: [
                      ElevatedCard(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            spacing: 8,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                spacing: 5,
                                children: [
                                  Icon(StoreGlyphs.settingsMedium, size: 16, color: Color(0xFF314158)),
                                  Text(
                                    "Specifications",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontVariations: [FontVariation('wght', 500)],
                                      color: Color(0xFF314158),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Serial Number",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: colorScheme.onSurfaceVariant,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            textAlign: TextAlign.end,
                                            widget.asset["naming_series"] ?? "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: colorScheme.onSurface,
                                              fontVariations: [FontVariation('wght', 600)],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: 1, color: colorScheme.onSurfaceVariant.withAlpha(20)),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Category",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: colorScheme.onSurfaceVariant,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            textAlign: TextAlign.end,
                                            widget.asset["asset_category"] ?? "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: colorScheme.onSurface,
                                              fontVariations: [FontVariation('wght', 600)],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: 1, color: colorScheme.onSurfaceVariant.withAlpha(20)),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Brand",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: colorScheme.onSurfaceVariant,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            textAlign: TextAlign.end,
                                            "Unknown",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: colorScheme.onSurface,
                                              fontVariations: [FontVariation('wght', 600)],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: 1, color: colorScheme.onSurfaceVariant.withAlpha(20)),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Manufacturer",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: colorScheme.onSurfaceVariant,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            textAlign: TextAlign.end,
                                            "Unknown",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: colorScheme.onSurface,
                                              fontVariations: [FontVariation('wght', 600)],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 15,
                    children: [
                      ElevatedCard(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            spacing: 8,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                spacing: 5,
                                children: [
                                  Icon(StoreGlyphs.settingsMedium, size: 16, color: Color(0xFF314158)),
                                  Text(
                                    "Linked Assets",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontVariations: [FontVariation('wght', 500)],
                                      color: Color(0xFF314158),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2),
                              ref
                                  .watch(batchedAssetsProvider(widget.asset["custom_batch"]))
                                  .when(
                                    data: (data) {
                                      return ListView.separated(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          final asset = data[index];
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFFf8fafc),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            padding: EdgeInsets.all(15),
                                            child: Row(
                                              children: [
                                                // Icon
                                                Container(
                                                  width: 45,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFe2e8f0),
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                  child: Icon(
                                                    StoreGlyphs.inventoryMedium,
                                                    color: Color(0xFF62748e),
                                                    size: 20,
                                                  ),
                                                ),
                                                SizedBox(width: 10),

                                                // Text content - wrapped in Expanded to prevent overflow
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        asset["item_name"],
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontVariations: [FontVariation('wght', 500)],
                                                          color: colorScheme.onSurface,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Linked Asset",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: colorScheme.onSurfaceVariant,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10),

                                                // Chevron icon
                                                Icon(
                                                  StoreGlyphs.chevronRightMedium,
                                                  size: 16,
                                                  color: colorScheme.onSurfaceVariant,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (_, _) {
                                          return SizedBox(height: 15);
                                        },
                                      );
                                    },
                                    loading: () => const Center(child: CircularProgressIndicator()),
                                    error: (e, st) => Center(child: Text("Error: $e")),
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //History
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: ElevatedCard(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 5,
                            children: [
                              Icon(StoreGlyphs.historyMedium, size: 16, color: Color(0xFF314158)),
                              Text(
                                "Activity Timeline",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontVariations: [FontVariation('wght', 500)],
                                  color: Color(0xFF314158),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Column(
                            spacing: 15,
                            children: [
                              if (widget.asset["custom_delivered_to_order_location"] == 1) ...[
                                TimelineItem(
                                  active: true,
                                  hideDivider: false,
                                  update: "Order Delivered",
                                  description:
                                      "Order delevered to ${widget.asset["custom_name_of_custodian"] ?? "Unknown"}",
                                ),
                              ] else ...[
                                TimelineItem(
                                  active: true,
                                  hideDivider: false,
                                  update: "Delivery Pending",
                                  description:
                                      "Delivery of ${widget.asset["item_name"] ?? "Unknown"} is pending",
                                ),
                              ],

                              if (widget.asset["custom_order_date"] != null)
                                TimelineItem(
                                  active: false,
                                  hideDivider: false,
                                  update: "Order Created",
                                  updateDate: widget.asset["custom_order_date"],
                                  author: widget.asset["custom_name_of_custodian"],
                                  description:
                                      "Order created for ${widget.asset["custom_name_of_custodian"] ?? "Unknown"}",
                                ),

                              if (widget.asset["purchase_date"] != null)
                                TimelineItem(
                                  active: false,
                                  hideDivider: false,
                                  update: "Purchased",
                                  updateDate: widget.asset["purchase_date"],
                                  author: widget.asset["custom_name_of_custodian"],
                                  description:
                                      "Asset Purchased by ${widget.asset["custom_name_of_custodian"] ?? "Unknown"}",
                                ),
                              TimelineItem(
                                active: false,
                                hideDivider: true,
                                update: "Asset Created",
                                updateDate: widget.asset["creation"].split(" ")[0],
                                author: "Administrator",
                                description: "Asset Created by Administrator",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _StickyTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.white, child: tabBar);
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return false;
  }
}
