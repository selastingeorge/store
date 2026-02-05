import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/fonts/store_glyphs.dart';
import 'package:store/core/types/order_status.dart';
import 'package:store/providers/order_provider.dart';
import 'package:store/views/widgets/elevated_card.dart';
import 'package:store/views/widgets/order_item.dart';
import 'package:store/views/widgets/timeline_item.dart';
import 'package:store/views/widgets/title_bar.dart';

class ViewOrderScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> order;
  const ViewOrderScreen({super.key, required this.order});

  @override
  ConsumerState<ViewOrderScreen> createState() => _ViewOrderScreenState();
}

class _ViewOrderScreenState extends ConsumerState<ViewOrderScreen> with SingleTickerProviderStateMixin {
  OrderStatus status = OrderStatus.draft;
  late TabController _tabController;

  String getOrderId(String creation) {
    final date = DateTime.parse(creation);
    final millis = date.millisecondsSinceEpoch;
    final id = (millis % 10000).toString().padLeft(4, '0');
    return id;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    status = OrderStatus.fromString(widget.order["status"]);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleBar(
        title: "Order Details",
        subtitle: "ORD-${getOrderId(widget.order["creation"])}",
        showBack: true,
        onBackPressed: () {
          context.pop();
        },
        showUserPicker: false,
        showLogout: false,
        height: 65,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: OrderStatus.getStatusBackgroundColor(status),
            ),
            child: Text(
              status.shortLabel,
              style: TextStyle(
                fontSize: 12,
                fontVariations: const [FontVariation('wght', 600)],
                color: OrderStatus.getStatusForegroundColor(status),
              ),
            ),
          ),
        ],
      ),
      body: ref
          .watch(itemsProvider(widget.order["name"]))
          .when(
            data: (items) {
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsetsGeometry.all(20),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            spacing: 10,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xFFe7ebee),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(StoreGlyphs.circleAlertMedium, size: 20),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Order #ORD-${getOrderId(widget.order["creation"])}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: colorScheme.onSurface,
                                      fontVariations: [FontVariation('wght', 900)],
                                    ),
                                  ),
                                  Text(
                                    "${items.length} Items",
                                    style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Color(0xFFf8fafc),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              spacing: 10,
                              children: [
                                Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.network(
                                    "https://ui-avatars.com/api/?name=${widget.order["requestor_name"] ?? "unknown"}",
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.order["requestor_name"] ?? "Unknown",
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis,
                                        color: colorScheme.onSurface,
                                        fontVariations: [FontVariation('wght', 500)],
                                      ),
                                    ),
                                    Text(
                                      widget.order["requestor"] ?? "N/A",
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 13,
                                        overflow: TextOverflow.ellipsis,
                                        color: colorScheme.onSurfaceVariant,
                                        fontVariations: [FontVariation('wght', 400)],
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
                  SliverToBoxAdapter(
                    child: Divider(color: colorScheme.onSurfaceVariant.withAlpha(10), height: 1),
                  ),
                  SliverPersistentHeader(
                    pinned: false,
                    delegate: _StickyTabBarDelegate(
                      TabBar(
                        controller: _tabController,
                        isScrollable: false,
                        indicatorWeight: 2,
                        labelColor: colorScheme.primary,
                        unselectedLabelColor: colorScheme.onSurfaceVariant,
                        indicatorColor: Color(0xFFdec3b3),
                        tabs: const [
                          Tab(text: 'Items'),
                          Tab(text: 'Delivery'),
                          Tab(text: 'Timeline'),
                        ],
                      ),
                    ),
                  ),
                ],
                body: Container(
                  color: Color(0xFFf8f2ef),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ///Items
                        ListView.separated(
                          itemBuilder: (_, i) {
                            final item = items[i];
                            return OrderItem(item: item);
                          },
                          separatorBuilder: (_, _) {
                            return SizedBox(height: 10);
                          },
                          itemCount: items.length,
                        ),

                        SingleChildScrollView(
                          child: Column(
                            spacing: 15,
                            children: [
                              ElevatedCard(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(StoreGlyphs.truck, size: 16, color: Color(0xFF314158)),
                                          SizedBox(width: 5),
                                          Text(
                                            "Delivery Method",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontVariations: [FontVariation('wght', 500)],
                                              color: Color(0xFF314158),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFf8fafc),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          spacing: 10,
                                          children: [
                                            Container(
                                              width: 45,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFd2dce4),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Icon(
                                                StoreGlyphs.truck,
                                                size: 20,
                                                color: colorScheme.onSurface,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Truck Delivery",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: colorScheme.onSurface,
                                                    fontVariations: [FontVariation('wght', 600)],
                                                  ),
                                                ),
                                                Text(
                                                  "Items will be delivered by truck",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: colorScheme.onSurfaceVariant,
                                                    fontVariations: [FontVariation('wght', 400)],
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
                                            "Delivery Location",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontVariations: [FontVariation('wght', 500)],
                                              color: Color(0xFF314158),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        spacing: 5,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (widget.order["emirate"] != null)
                                            Text(
                                              widget.order["emirate"],
                                              style: TextStyle(fontSize: 14, color: colorScheme.onSurface),
                                            ),
                                          Text(
                                            widget.order["country"],
                                            style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ElevatedCard(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(StoreGlyphs.calendarMedium, size: 16, color: Color(0xFF314158)),
                                          SizedBox(width: 5),
                                          Text(
                                            "Delivery Schedule",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontVariations: [FontVariation('wght', 500)],
                                              color: Color(0xFF314158),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        spacing: 5,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.order["status"].toString().toLowerCase() == "delivered"
                                                ? "Order Delivered"
                                                : "Delivery Expected",
                                            style: TextStyle(fontSize: 14, color: colorScheme.onSurface),
                                          ),
                                          Text(
                                            widget.order["delivery_date"] ?? "Unknown",
                                            style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Timeline,
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
                                          "Order Timeline",
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
                                        if (widget.order["status"].toString().toLowerCase() == "delivered") ...[
                                          TimelineItem(
                                            active: true,
                                            hideDivider: false,
                                            update: "Order Delivered",
                                            description:
                                            "Order delevered on ${widget.order["delivery_date"] ?? "Unknown"}",
                                          ),
                                        ] else ...[
                                          TimelineItem(
                                            active: true,
                                            hideDivider: false,
                                            update: "Delivery Pending",
                                            description:
                                            "Delivery of ${widget.order["item_name"] ?? "Unknown"} is pending",
                                          ),
                                        ],

                                        if (widget.order["order_date"] != null)
                                          TimelineItem(
                                            active: false,
                                            hideDivider: true,
                                            update: "Order Created",
                                            updateDate: widget.order["custom_order_date"],
                                            author: widget.order["custom_name_of_custodian"],
                                            description:
                                            "Order ${widget.order["name"] ?? "Unknown"} Created",
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
            },
            error: (e, s) {
              return Text("Unable to load data");
            },
            loading: () {
              return Expanded(
                child: Center(
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(strokeCap: StrokeCap.round),
                  ),
                ),
              );
            },
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
