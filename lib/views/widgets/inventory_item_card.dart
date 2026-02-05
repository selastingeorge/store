import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store/config.dart';
import 'package:store/core/fonts/store_glyphs.dart';
import 'package:store/core/types/asset_status.dart';
import 'package:store/views/widgets/elevated_card.dart';
import 'package:store/views/widgets/image_carousel.dart';

class InventoryItemCard extends StatefulWidget {
  final Map<String, dynamic> asset;
  final VoidCallback? onTap;
  const InventoryItemCard({super.key, required this.asset, this.onTap});

  @override
  State<InventoryItemCard> createState() => _InventoryItemCardState();
}

class _InventoryItemCardState extends State<InventoryItemCard> {
  String total = "\$0";
  final List<String> images = [];
  String id = "#24";
  bool liked = false;

  @override
  void initState() {
    super.initState();

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
      onTap: widget.onTap,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 170,
              child: Stack(
                children: [
                  if (images.isNotEmpty) ...[
                    ImageCarousel(
                      images: images,
                      showIndicator: true,
                      borderRadius: BorderRadius.zero,
                      enlargeCenterImage: false,
                      itemPadding: EdgeInsets.zero,
                    ),
                  ] else ...[
                    Image.asset('assets/images/placeholder-image.png', height: 170, fit: BoxFit.cover),
                  ],
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AssetStatus.getStatusBackgroundColor(
                          AssetStatus.fromLabel(widget.asset["status"]),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      child: Text(
                        widget.asset["status"],
                        style: TextStyle(
                          fontSize: 10,
                          fontVariations: [FontVariation('wght', 600)],
                          color: AssetStatus.getStatusForegroundColor(
                            AssetStatus.fromLabel(widget.asset["status"]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(80),
                            blurRadius: 16,
                            spreadRadius: -8,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            setState(() {
                              liked = !liked;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Icon(
                              liked ? StoreGlyphs.heartFilledMedium : StoreGlyphs.heartMedium,
                              color: liked ? Colors.red : colorScheme.onSurfaceVariant,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.asset["asset_name"] ?? "Unknown Asset",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontVariations: [FontVariation('wght', 500)],
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                          const SizedBox(width: 2),
                          Text(
                            "${ratingFromTitle(widget.asset["asset_name"])}",
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
                  const SizedBox(height: 5),
                  Text(
                    widget.asset["asset_category"],
                    style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        total,
                        style: TextStyle(
                          fontSize: 16,
                          fontVariations: [FontVariation('wght', 900)],
                          color: colorScheme.onSurface,
                        ),
                      ),
                      Text("ID:$id", style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
