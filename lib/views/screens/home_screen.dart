import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/fonts/store_glyphs.dart';
import 'package:store/notifier/tab_notifier.dart';
import 'package:store/notifier/user_notifier.dart';
import 'package:store/views/screens/dashboard_screen.dart';
import 'package:store/views/screens/inventory_screen.dart';
import 'package:store/views/screens/orders_screen.dart';
import 'package:store/views/widgets/double_back_exit.dart';
import 'package:store/views/widgets/title_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late PageController _pageController;
  final List<Widget> _pages = [const DashboardScreen(), const InventoryScreen(), const OrdersScreen()];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final tab = ref.watch(tabProvider);

    ref.listen(tabProvider, (prev, next) {
      if (_pageController.hasClients && prev != next) {
        _pageController.animateToPage(
          next.tabIndex,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    });

    return DoubleBackExit(child:Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: TitleBar(
        showBack: tab.isBackAvailable,
        height: 65,
        title: tab.tabTitle,
        subtitle: user.name.toUpperCase(),
        onBackPressed: (){
          ref.read(tabProvider.notifier).setTab(0);
        },
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        elevation: 10,
        surfaceTintColor: Colors.white,
        selectedIndex: tab.tabIndex,
        onDestinationSelected: (index) {
          if (index == 3) {
            context.push("/profile");
          } else {
            setState(() {
              ref.read(tabProvider.notifier).setTab(index);
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            });
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(StoreGlyphs.dashboardMedium, size: 20), label: "Dashboard"),
          NavigationDestination(icon: Icon(StoreGlyphs.inventoryMedium, size: 20), label: "Inventory"),
          NavigationDestination(icon: Icon(StoreGlyphs.ordersMedium, size: 20), label: "Orders"),
          NavigationDestination(icon: Icon(StoreGlyphs.profileMedium, size: 20), label: "Profile"),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
