import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/fonts/store_glyphs.dart';
import 'package:store/models/user.dart';
import 'package:store/notifier/auth_notifier.dart';
import 'package:store/providers/inventory_provider.dart';
import 'package:store/views/widgets/asset_item.dart';
import 'package:store/views/widgets/elevated_card.dart';
import 'package:store/views/widgets/stats_card.dart';
import 'package:store/views/widgets/title_bar.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  User? user;
  @override
  void initState() {
    super.initState();
    user = ref.read(authProvider).user;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: TitleBar(
        showBack: true,
        showUserPicker: false,
        showLogout: false,
        height: 65,
        onBackPressed: () {
          context.pop();
        },
        customContent: Row(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: Color(0xFFd2dce4), borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Text(
                  user?.fullName[0] ?? "A",
                  style: TextStyle(fontSize: 14, fontVariations: [FontVariation('wght', 900)]),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user?.fullName ?? "Administrator",
                  style: TextStyle(fontSize: 18, fontVariations: [FontVariation('wght', 700)]),
                ),
                Text(
                  user?.roleProfileName.toUpperCase() ?? "Administrator".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontVariations: [FontVariation('wght', 400)],
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Color(0xFFf8f2ef),
        padding: EdgeInsets.all(15),
        child: Column(
          spacing: 15,
          children: [
            Row(
              spacing: 15,
              children: [
                Expanded(
                  child: StatsCard(
                    label: "Assets Held",
                    icon: StoreGlyphs.inventoryMedium,
                    iconBackground: Color(0xFFd2dce4),
                    iconForeground: Color(0xFF314158),
                    trendValue: 3,
                    value: 4,
                    trendValueSuffix: " In Use",
                  ),
                ),

                Expanded(
                  child: StatsCard(
                    label: "Total Orders",
                    icon: StoreGlyphs.ordersMedium,
                    iconBackground: Color(0xFFdec3b3),
                    iconForeground: Color(0xFF314158),
                    trendValue: 1,
                    value: 4,
                    trendValueSuffix: " completed",
                  ),
                ),
              ],
            ),

            DefaultTabController(
              length: 2,
              child: ElevatedCard(
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(text: "Assets"),
                        Tab(text: "Orders"),
                      ],
                    ),
                    SizedBox(
                      height: 400,
                      child: TabBarView(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                            child: ref
                                .watch(userAssetsProvider)
                                .when(
                                  data: (data) {
                                    return ListView.separated(
                                      itemBuilder: (c, i) {
                                        final asset = data[i];
                                        return AssetItem(asset: asset);
                                      },
                                      separatorBuilder: (c, i) {
                                        return SizedBox(height: 10);
                                      },
                                      itemCount: data.length,
                                    );
                                  },
                                  error: (e, s) {
                                    return Text("Error,$e");
                                  },
                                  loading: () {
                                    return Center(
                                      child: SizedBox(
                                        width: 32,
                                        height: 32,
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  },
                                ),
                          ),

                          Padding(padding: EdgeInsets.only(left: 50,right: 50,top:15),child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFf8f2ef),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(child: Icon(StoreGlyphs.ordersMedium)),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "No Orders found",
                                  style: TextStyle(fontSize: 18, fontVariations: [FontVariation('wght', 600)]),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "No Assets found matching this criteria, please try again",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
