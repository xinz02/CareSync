
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onlyu_cafe/cart/cart.dart';
import 'package:onlyu_cafe/home.dart';
import 'package:onlyu_cafe/main.dart';
import 'package:onlyu_cafe/user_management/login.dart';
import 'package:onlyu_cafe/user_management/profile.dart';
import 'package:onlyu_cafe/user_management/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool isAuthenticated() {
  // Check if there's a user logged in
  return FirebaseAuth.instance.currentUser != null;
}

GoRouter goRouter() {
  return GoRouter(
    initialLocation: '/main',
    routes: [
      GoRoute(
        path: '/main',
        builder: (context, state) => const NavigationBarExample(),
      ),
      GoRoute(
        path: '/menu',
        builder: (context, state) => const MenuPage(),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUp(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) =>
            isAuthenticated() ? const ProfilePage() : const Login(),
        redirect: (context, state) {
          // Check if user is authenticated
          if (!isAuthenticated()) {
            // return '/login';
            context.go("/login");
            context.go("/main");
          }
          return "/profile";
        },
      ),
      GoRoute(
        path: '/dinein',
        builder: (context, state) =>
            isAuthenticated() ? const MenuPage() : const Login(),
        redirect: (context, state) {
          // Check if user is authenticated
          if (!isAuthenticated()) {
            // return '/login';
            context.push("/login");
          }
          return "/menu";
        },
      ),
    ],
  );
}

// final goRouter = GoRouter(
//   initialLocation: '/home',
//   routes: [
//     GoRoute(
//       path: '/signup',
//       builder: (context, state) => const SignUp(),
//     ),
//     GoRoute(
//       path: '/login',
//       builder: (context, state) => const Login(),
//     ),
//     ShellRoute(
//       navigatorKey: GlobalKey<
//           NavigatorState>(), // Optional, for handling nested navigation
//       builder: (context, state, child) {
//         return MyShell(child: child); // Use the shell layout
//       },
//       routes: [
//         GoRoute(
//           path: '/home',
//           builder: (context, state) =>
//               const HomePage(), // Define the Home screen
//         ),
//         GoRoute(
//           path: '/menu',
//           builder: (context, state) =>
//               const MenuPage(), // Define the Search screen
//         ),
//         GoRoute(
//           path: '/profile',
//           builder: (context, state) =>
//               isAuthenticated() ? const ProfilePage() : const Login(),
//           redirect: (context, state) {
//             // Check if user is authenticated
//             if (!isAuthenticated()) {
//               return '/login';
//             }
//             return null;
//           },
//         ),
//       ],
//     ),
//   ],
// );
