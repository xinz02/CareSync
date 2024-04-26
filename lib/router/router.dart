import 'package:go_router/go_router.dart';
import 'package:onlyu_cafe/cart/cart.dart';
import 'package:onlyu_cafe/home.dart';
import 'package:onlyu_cafe/main.dart';
import 'package:onlyu_cafe/user_management/profile.dart';
import 'package:onlyu_cafe/user_management/signup.dart';

GoRouter goRouter() {
  return GoRouter(initialLocation: '/main', routes: <RouteBase>[
    GoRoute(
        path: '/main',
        builder: ((context, state) => const NavigationBarExample())),
    GoRoute(path: '/menu', builder: ((context, state) => const MenuPage())),
    GoRoute(
        path: '/profile', builder: ((context, state) => const ProfilePage())),
    GoRoute(path: '/cart', builder: ((context, state) => const CartPage())),
    GoRoute(path: '/signup', builder: ((context, state) => const SignUp())),
    GoRoute(path: '/home', builder: ((context, state) => const HomePage())),
  ]);
}
