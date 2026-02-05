import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/fonts/store_glyphs.dart';
import 'package:store/views/widgets/elevated_card.dart';

class InventoryCardPlaceholder extends StatelessWidget {
  const InventoryCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Skeletonizer(
      child: ElevatedCard(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 170,
                child: Stack(
                  children: [
                    Image.asset('assets/images/placeholder-image.png', height: 170, fit: BoxFit.cover),
                    Positioned(
                      left: 10,
                      top: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: Text(
                          "Sample",
                          style: TextStyle(fontSize: 10, fontVariations: [FontVariation('wght', 600)]),
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

                            child: Padding(
                              padding: EdgeInsets.all(6),
                              child: Icon(
                                StoreGlyphs.heartMedium,
                                color: colorScheme.onSurfaceVariant,
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
                            "Unknown Asset",
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
                              "4.0",
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
                    Text("Sample", style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$500",
                          style: TextStyle(
                            fontSize: 16,
                            fontVariations: [FontVariation('wght', 900)],
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Text("ID:001", style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
