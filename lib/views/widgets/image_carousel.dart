import 'dart:async';
import 'package:flutter/material.dart';

/// A customizable and reusable image carousel widget.
///
/// Supports autoplay, center image scaling (vertical only), infinite looping,
/// indicator display, and padding around individual items.
/// Optimized for high performance with proper image cropping.
///
/// ### Example usage:
/// ```dart
/// ImageCarousel(
///   images: [
///     'assets/images/img1.jpg',
///     'assets/images/img2.jpg',
///     'assets/images/img3.jpg',
///   ],
///   enlargeCenterImage: true,
///   autoplay: true,
///   showIndicator: true,
///   itemPadding: EdgeInsets.all(8.0),
///   autoplayInterval: Duration(seconds: 4),
///   borderRadius: BorderRadius.circular(16)
/// )
/// ```
class ImageCarousel extends StatefulWidget {
  /// List of asset paths for images to display in the carousel
  final List<String> images;

  /// Whether to apply vertical scaling effect to the center image (makes it taller)
  final bool enlargeCenterImage;

  /// Enables automatic progression through images
  final bool autoplay;

  /// Shows page indicator dots below the carousel
  final bool showIndicator;

  /// Padding applied around each individual carousel item
  final EdgeInsets itemPadding;

  /// Time interval between automatic page changes when autoplay is enabled
  final Duration autoplayInterval;

  /// Border radius for image corners (rounded corners effect)
  final BorderRadius borderRadius;

  final bool showOverlay;

  const ImageCarousel({
    super.key,
    required this.images,
    this.enlargeCenterImage = false,
    this.autoplay = false,
    this.showIndicator = false,
    this.itemPadding = const EdgeInsets.all(8.0),
    this.autoplayInterval = const Duration(seconds: 3),
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.showOverlay = false
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  /// Multiplier used to create infinite scrolling effect
  /// Creates a virtual list 100x longer than actual items
  static const int _loopMultiplier = 100;

  /// PageController to manage carousel scrolling
  late final PageController _controller;

  /// Actual number of images in the carousel
  late final int _realItemCount;

  /// Initial page position (middle of virtual list for infinite scrolling)
  late final int _initialPage;

  /// Notifier to track current visible image index for indicators
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  /// Timer for autoplay functionality
  Timer? _autoplayTimer;

  @override
  void initState() {
    super.initState();

    // Store the actual number of images
    _realItemCount = widget.images.length;

    // Calculate starting position at middle of virtual list
    // This allows scrolling in both directions infinitely
    _initialPage = _realItemCount * _loopMultiplier;

    // Initialize PageController with starting position and full viewport
    _controller = PageController(initialPage: _initialPage, viewportFraction: 1.0);

    // Start autoplay timer if autoplay is enabled
    if (widget.autoplay) {
      _startAutoplay();
    }
  }

  /// Starts the autoplay timer that automatically advances pages
  void _startAutoplay() {
    // Cancel any existing timer to avoid duplicates
    _autoplayTimer?.cancel();

    // Create periodic timer that advances to next page
    _autoplayTimer = Timer.periodic(widget.autoplayInterval, (_) {
      // Check if controller is attached to widget before using
      if (_controller.hasClients) {
        _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  /// Stops the autoplay timer (used when user interacts)
  void _stopAutoplay() {
    _autoplayTimer?.cancel();
    _autoplayTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main carousel container
        Expanded(
          child: Listener(
            // Pause autoplay when user touches the screen
            onPointerDown: (_) => _stopAutoplay(),
            // Resume autoplay when user releases touch
            onPointerUp: (_) {
              if (widget.autoplay) _startAutoplay();
            },
            child: Stack(
              children: [

                PageView.builder(
                  padEnds: false,
                  controller: _controller,
                  // Update current index for indicators when page changes
                  onPageChanged: (index) {
                    // Convert virtual index back to real image index
                    _currentIndex.value = index % _realItemCount;
                  },
                  // Build each page of the carousel
                  itemBuilder: (context, index) {
                    // Convert virtual index to actual image index
                    final realIndex = index % _realItemCount;

                    return AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        // Calculate height multiplier for center image enlargement effect
                        double heightMultiplier = 1.0;
                        if (widget.enlargeCenterImage && _controller.position.haveDimensions) {
                          // Get current page position
                          final page = _controller.page ?? _controller.initialPage.toDouble();
                          // Calculate distance from center
                          final distance = (page - index).abs();
                          // Apply height scaling based on distance (closer = taller)
                          // Scale ranges from 0.85 to 1 for subtle effect
                          heightMultiplier = (1.15 - distance * 0.3).clamp(0.85, 1);
                        }

                        return Padding(
                          padding: widget.itemPadding,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              // Calculate the dynamic height based on available space and multiplier
                              final baseHeight = constraints.maxHeight;
                              final dynamicHeight = baseHeight * heightMultiplier;

                              return Center(
                                child: ClipRRect(
                                  // Apply custom border radius for rounded corners
                                  borderRadius: widget.borderRadius,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: dynamicHeight,
                                    child: Image.network(
                                      widget.images[realIndex],
                                      // Use cover to maintain aspect ratio and crop naturally
                                      fit: BoxFit.cover,
                                      // Optimize performance with caching
                                      filterQuality: FilterQuality.medium,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
                if(widget.showOverlay)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(10),
                        ),
                      ),
                    ),
                  ),

                Positioned(
                  left: 6,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _navButton(
                      icon: Icons.chevron_left,
                      onTap: () {
                        _controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                    ),
                  ),
                ),

                Positioned(
                  right: 6,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _navButton(
                      icon: Icons.chevron_right,
                      onTap: () {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                    ),
                  ),
                ),
                if (widget.showIndicator)
                  Positioned(bottom: 10, left: 0, right: 0, child: Center(child: _buildIndicators())),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _navButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
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
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Icon(icon, color: Colors.black, size: 22),
          ),
        ),
      ),
    );
  }

  /// Builds the page indicator dots below the carousel
  Widget _buildIndicators() {
    return ValueListenableBuilder<int>(
      valueListenable: _currentIndex,
      builder: (context, current, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_realItemCount, (index) {
            // Check if this indicator represents the current page
            final isActive = index == current;

            return AnimatedContainer(
              // Smooth animation when switching indicators
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3.0),
              // Active indicator is wider than inactive ones
              width: isActive ? 14 : 6,
              height: 6,
              decoration: BoxDecoration(
                // Active indicator is fully opaque, inactive are semi-transparent
                color: isActive ? Colors.white : Colors.white.withAlpha(200),
                borderRadius: BorderRadius.circular(16),
              ),
            );
          }),
        );
      },
    );
  }

  /// Clean up resources to prevent memory leaks
  @override
  void dispose() {
    _controller.dispose();
    _currentIndex.dispose();

    // Cancel any running timers
    _stopAutoplay();
    super.dispose();
  }
}
