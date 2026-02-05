import 'package:flutter/material.dart';

class ElevatedCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final BorderRadius borderRadius;

  const ElevatedCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(0),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 2, offset: const Offset(0, 2))],
      ),
      child: Material(
        color: colorScheme.surface,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          splashColor: onTap == null ? Colors.transparent : colorScheme.primary.withAlpha(10),
          highlightColor: onTap == null ? Colors.transparent : colorScheme.primary.withAlpha(10),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
