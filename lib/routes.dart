import 'package:go_router/go_router.dart';
import 'package:store/views/screens/home_screen.dart';
import 'package:store/views/screens/my_assets_screen.dart';
import 'package:store/views/screens/profile_screen.dart';
import 'package:store/views/screens/sign_in_screen.dart';
import 'package:store/views/screens/splash_screen.dart';
import 'package:store/views/screens/users_screen.dart';
import 'package:store/views/screens/view_asset_screen.dart';
import 'package:store/views/screens/view_order_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, _) => SplashScreen()),
    GoRoute(path: '/sign-in', builder: (_, _) => SignInScreen()),
    GoRoute(path: '/home', builder: (_, _) => HomeScreen()),
    GoRoute(path: '/profile', builder: (_, _) => ProfileScreen()),
    GoRoute(path: '/my-assets', builder: (_, _) => MyAssetsScreen()),
    GoRoute(path: '/users', builder: (_, _) => UsersScreen()),
    GoRoute(
      path: '/view-asset',
      builder: (_, state) => ViewAssetScreen(asset: state.extra as Map<String, dynamic>),
    ),
    GoRoute(
      path: '/view-order',
      builder: (_, state) => ViewOrderScreen(order: state.extra as Map<String, dynamic>),
    ),
  ],
);
