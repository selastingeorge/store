import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/fonts/store_glyphs.dart';
import 'package:store/core/types/order_status.dart';
import 'package:store/views/widgets/elevated_card.dart';

class OrderCardPlaceholder extends StatelessWidget {
  const OrderCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Skeletonizer(child: ElevatedCard(
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
                            "Sample Order name",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontVariations: [FontVariation('wght', 500)],
                              color: colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            "Order ID: ORD-1112",
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
                        color: OrderStatus.getStatusBackgroundColor(OrderStatus.draft),
                      ),
                      child: Text(
                        "label",
                        style: TextStyle(
                          fontSize: 12,
                          fontVariations: const [FontVariation('wght', 600)],
                          color: OrderStatus.getStatusForegroundColor(OrderStatus.draft),
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
                    "Order for Unknown",
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
                            "20-10-2008",
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
                            ).format(100),
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
                      "United Arab Emirates",
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
                    "Unknown",
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
    ));
  }
}
