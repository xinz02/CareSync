import 'package:go_router/go_router.dart';
import 'package:onlyu_cafe/cart.dart';
import 'package:onlyu_cafe/main.dart';
import 'package:onlyu_cafe/signup.dart';

GoRouter goRouter() {
  return GoRouter(initialLocation: '/home', routes: <RouteBase>[
    GoRoute(path: '/home', builder: ((context, state) => const MyHomePage())),
    GoRoute(
        path: '/donothing',
        builder: ((context, state) => const DoNothingPage())),
    GoRoute(path: '/cart', builder: ((context, state) => const CartPage())),
    GoRoute(path: '/signup', builder: ((context, state) => const SignUp())),
  ]);
}
