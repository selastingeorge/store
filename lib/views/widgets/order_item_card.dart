import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store/core/fonts/store_glyphs.dart';
import 'package:store/core/types/order_status.dart';
import 'package:store/views/widgets/elevated_card.dart';

class OrderItemCard extends StatefulWidget {
  final Map<String, dynamic> order;
  final VoidCallback? onTap;
  const OrderItemCard({super.key, required this.order, this.onTap});

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  OrderStatus status = OrderStatus.draft;

  @override
  void initState() {
    super.initState();
    status = OrderStatus.fromString(widget.order["status"]);
  }

  String getOrderId(String creation) {
    final date = DateTime.parse(creation);
    final millis = date.millisecondsSinceEpoch;
    final id = (millis % 10000).toString().padLeft(4, '0');
    return id;
  }

  double getOrderAmount(String creation, {double min = 120, double max = 1250}) {
    final hash = creation.hashCode & 0x7fffffff;
    final normalized = hash / 0x7fffffff;

    final amount = min + (max - min) * normalized;
    return double.parse(amount.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ElevatedCard(
      onTap: widget.onTap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color(0xFFe7ebee),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(StoreGlyphs.ordersMedium, size: 20, color: Color(0xFF45556c)),
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.order["name"],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontVariations: [FontVariation('wght', 500)],
                              color: colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            "Order ID: ORD-${getOrderId(widget.order["creation"])}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontVariations: [FontVariation('wght', 400)],
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 10),
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
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFf8fafc),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Order for ${widget.order["requestor_name"] ?? "Unknown"}",
                    style: TextStyle(fontSize: 12, color: Color(0xFF45556c)),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        spacing: 5,
                        children: [
                          Icon(StoreGlyphs.calendarMedium, size: 14, color: colorScheme.onSurfaceVariant),
                          Text(
                            widget.order["order_date"] ?? "N/A",
                            style: TextStyle(fontSize: 12, color: Color(0xFF45556c)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        spacing: 5,
                        children: [
                          Icon(StoreGlyphs.dollarMedium, size: 14, color: colorScheme.onSurfaceVariant),
                          Text(
                            NumberFormat.currency(
                              symbol: '\$',
                            ).format(getOrderAmount(widget.order["creation"])),
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF45556c),
                              fontVariations: [FontVariation('wght', 600)],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1,color: colorScheme.onSurfaceVariant.withAlpha(10),),
          Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 15), child: Row(
            children: [
              Expanded(
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(StoreGlyphs.mapPinMedium, size: 14, color: colorScheme.onSurfaceVariant),
                    Text(
                      (widget.order["emirate"] == null || widget.order["emirate"].isEmpty)? "United Arab Emirates":widget.order["emirate"],
                      style: TextStyle(fontSize: 12, color: Color(0xFF45556c)),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: 5,
                children: [
                  Icon(StoreGlyphs.profileMedium, size: 14, color: colorScheme.onSurfaceVariant),
                  Text(
                    widget.order["requestor_name"]??"Unknown",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF45556c),
                      fontVariations: [FontVariation('wght', 400)],
                    ),
                  ),
                ],
              )
            ],
          ),),
        ],
      ),
    );
  }
}
