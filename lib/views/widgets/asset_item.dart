import 'package:flutter/material.dart';
import 'package:store/config.dart';
import 'package:store/core/fonts/store_glyphs.dart';
import 'package:store/views/widgets/elevated_card.dart';

class AssetItem extends StatelessWidget {
  final Map<String, dynamic> asset;
  const AssetItem({super.key, required this.asset});

  double ratingFromTitle(String title, {double min = 4, double max = 5}) {
    final hash = title.hashCode;
    final normalized = (hash & 0x7fffffff) / 0x7fffffff;
    final rating = min + (max - min) * normalized;
    return double.parse(rating.toStringAsFixed(1));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ElevatedCard(
      child: Row(
        spacing: 15,
        children: [
          if(asset["image"]==null)
            Image.asset("assets/images/placeholder-image.png", width: 80,height: 90, fit: BoxFit.cover)
          else
            Image.network("${Config.apiUrl}/${asset["image"]}", width: 80,height: 90, fit: BoxFit.cover),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                asset["item_name"],
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                  fontVariations: [FontVariation('wght', 500)],
                  color: colorScheme.onSurface,
                ),
              ),
              Text(
                asset["asset_category"],
                maxLines: 1,
                style: TextStyle(
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                  fontVariations: [FontVariation('wght', 400)],
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 10),
              Row(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 5,
                    children: [
                      Icon(StoreGlyphs.calendarMedium, size: 12, color: colorScheme.onSurfaceVariant),
                      Text(
                        asset["custom_order_date"] ?? "Unknown",
                        style: TextStyle(
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                          fontVariations: [FontVariation('wght', 400)],
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text(
                        "${ratingFromTitle(asset["asset_name"])}",
                        style: TextStyle(
                          fontSize: 12,
                          fontVariations: [FontVariation('wght', 500)],
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
