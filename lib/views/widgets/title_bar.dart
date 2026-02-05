import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/fonts/store_glyphs.dart';
import 'package:store/notifier/user_notifier.dart';
import 'package:store/providers/auth_provider.dart';

class TitleBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  final bool showBack;
  final double height;
  final String? title;
  final String? subtitle;
  final VoidCallback? onBackPressed;
  final bool showLogout;
  final bool showUserPicker;
  final Widget? customContent;
  final List<Widget>? actions;

  const TitleBar({
    super.key,
    this.height = kToolbarHeight,
    this.showBack = false,
    this.title,
    this.subtitle,
    this.onBackPressed,
    this.showLogout = true,
    this.showUserPicker = true,
    this.customContent,
    this.actions,
  });

  @override
  ConsumerState<TitleBar> createState() => _TitleBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _TitleBarState extends ConsumerState<TitleBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).appBarTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final user = ref.watch(userProvider);

    return SafeArea(
      child: Container(
        height: widget.height,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              offset: Offset(0, 4),
              blurRadius: 3,
              spreadRadius: -5,
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              if (widget.showBack) ...[
                IconButton(
                  onPressed: widget.onBackPressed,
                  icon: Icon(StoreGlyphs.arrowLeftMedium, color: theme.foregroundColor, size: 20),
                ),
                SizedBox(width: 6),
              ],

              if (!widget.showBack) ...[SizedBox(width: 10)],

              // Custom content or default title/subtitle
              if (widget.customContent != null)
                widget.customContent!
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.title != null) ...[
                      Text(
                        widget.title!,
                        style: TextStyle(fontSize: 18, fontVariations: [FontVariation('wght', 700)]),
                      ),
                    ],
                    if (widget.subtitle != null) ...[
                      Text(
                        widget.subtitle!,
                        style: TextStyle(
                          fontSize: 12,
                          fontVariations: [FontVariation('wght', 400)],
                          color: colorScheme.onSurfaceVariant,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ],
                ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Custom actions
                    if (widget.actions != null) ...widget.actions!,

                    // User picker dropdown
                    if (widget.showUserPicker) ...[
                      PopupMenuButton<String>(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 80),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Color(0xFFe7ebee),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  user.shortDisplayName,
                                  style: TextStyle(fontSize: 12, fontVariations: [FontVariation('wght', 400)]),
                                ),
                                SizedBox(width: 5),
                                Icon(StoreGlyphs.chevronDownMedium, size: 14),
                              ],
                            ),
                          ),
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(value: 'l1', child: Text('L1')),
                          PopupMenuItem(value: 'l2', child: Text('L2')),
                          PopupMenuItem(value: 'manager', child: Text('Manager')),
                          PopupMenuItem(value: 'group_manager', child: Text('Group Manager')),
                          PopupMenuItem(value: 'admin', child: Text('Admin')),
                        ],
                        onSelected: (value) {
                          ref.read(userProvider.notifier).setUserRoleFromString(value);
                        },
                      ),
                      SizedBox(width: 8),
                    ],

                    // Logout button
                    if (widget.showLogout)
                      IconButton(
                        onPressed: () async {
                          await ref.read(authRepositoryProvider).signOut();
                          if (context.mounted) {
                            context.go("/sign-in");
                          }
                        },
                        icon: Icon(StoreGlyphs.logOutMedium),
                        iconSize: 20,
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