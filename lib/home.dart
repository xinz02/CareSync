// import 'package:flutter/material.dart';
// import 'package:onlyu_cafe/main.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 248, 240, 238),
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 229, 202, 195),
//         title: const Text("Home Page",
//             style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black)),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//                 onPressed: () {
//                   context.push("/donothing");
//                 },
//                 child: const Text("DoNothing")),
//             ElevatedButton(
//                 onPressed: () {
//                   context.push("/cart");
//                 },
//                 child: const Text("Cart"))
//           ],
//         ),
//       ),
//     );
//   }
// }
