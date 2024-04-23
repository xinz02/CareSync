import 'package:go_router/go_router.dart';
import 'package:onlyu_cafe/cart/cart.dart';
import 'package:onlyu_cafe/home.dart';
import 'package:onlyu_cafe/main.dart';
import 'package:onlyu_cafe/user_management/signup.dart';

GoRouter goRouter() {
  return GoRouter(initialLocation: '/test', routes: <RouteBase>[
    GoRoute(path: '/home', builder: ((context, state) => const MenuPage())),
    GoRoute(
        path: '/donothing',
        builder: ((context, state) => const DoNothingPage())),
    GoRoute(path: '/cart', builder: ((context, state) => const CartPage())),
    GoRoute(path: '/signup', builder: ((context, state) => const SignUp())),
    GoRoute(path: '/test', builder: ((context, state) => const HomePage())),
  ]);
}
