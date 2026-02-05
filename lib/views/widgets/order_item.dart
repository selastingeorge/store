import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store/config.dart';
import 'package:store/views/widgets/elevated_card.dart';

class OrderItem extends StatelessWidget {
  final Map<String, dynamic> item;
  const OrderItem({super.key, required this.item});

  String getPriceFromTitle(String title, {double min = 50, double max = 500}) {
    final hash = title.hashCode & 0x7fffffff;
    final normalized = hash / 0x7fffffff;
    final price = min + (max - min) * normalized;

    final formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);
    return formatter.format(price);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ElevatedCard(
      child: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: Row(
          spacing: 15,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: (item["item_image"] != null)
                  ? Image.network(
                      "${Config.apiUrl}/${item["item_image"]}",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "assets/images/placeholder-image.png",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['item_name'],
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurface,
                    overflow: TextOverflow.ellipsis,
                    fontVariations: [FontVariation('wght', 700)],
                  ),
                ),
                Text(
                  "Code:${item['sku']}",
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                    fontVariations: [FontVariation('wght', 400)],
                  ),
                ),
                Text(
                  "Category: Unknown",
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                    fontVariations: [FontVariation('wght', 400)],
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left side
                    Row(
                      children: [
                        Text(
                          "Qty:",
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant,
                            fontVariations: [FontVariation('wght', 400)],
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          item["qty"].toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurface,
                            fontVariations: [FontVariation('wght', 600)],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 50,),
                    Row(
                      children: [
                        Text(
                          "Unit:",
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant,
                            fontVariations: [FontVariation('wght', 400)],
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          getPriceFromTitle(item['item_name']).toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurface,
                            fontVariations: [FontVariation('wght', 600)],
                          ),
                        ),
                      ],
                    ),
                  ],
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}
