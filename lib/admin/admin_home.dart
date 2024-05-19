// ignore_for_file: unnecessary_const

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onlyu_cafe/admin/admin_menu.dart';
import 'package:onlyu_cafe/admin/admin_order.dart';
import 'package:onlyu_cafe/main.dart';
// import 'package:onlyu_cafe/main.dart';
import 'package:onlyu_cafe/service/auth.dart';
import 'package:onlyu_cafe/user_management/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 240, 238),
        // body: Center(child: Text("Home Page")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              // Container(
              //   width: 225,
              //   height: 130,
              //   decoration: const BoxDecoration(
              //       color: Color.fromARGB(255, 195, 133, 134),
              //       borderRadius: BorderRadius.all(Radius.circular(5))),
              //   child: const Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[Text("Upcoming Orders:"), Text("20")],
              //   ),
              ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const AdminOrderPage(), // Replace OrderPage with your actual order page
                        ),
                      ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 195, 133, 134),
                      // padding: const EdgeInsets.fromLTRB(45, 25, 15, 25),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minimumSize: const Size(325, 55)),
                  child: const SizedBox(
                    width: 315,
                    height: 135,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Upcoming Orders:",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "20",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 110,
                    height: 75,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 237, 219, 219),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.menu_book),
                          SizedBox(height: 4),
                          Text('Menu'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    height: 75,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 237, 219, 219),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.summarize),
                          SizedBox(height: 4),
                          Text('Report'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    height: 75,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 237, 219, 219),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.feedback),
                          SizedBox(height: 4),
                          Text('Feedback'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 30,
              ),
              const Card(
                child: const ListTile(
                  // leading: Image.network(
                  //   'https://via.placeholder.com/50', // Replace with your image URL
                  // ),
                  title: Text('Coco Chocolate Cake'),
                  subtitle: Text('Qty: 15'),
                  trailing: Icon(Icons.whatshot, color: Colors.red),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Card(
                child: ListTile(
                  // leading: Image.network(
                  //   'https://via.placeholder.com/50', // Replace with your image URL
                  // ),
                  title: Text('Coco Chocolate Cake'),
                  subtitle: Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                    ],
                  ),
                  trailing: Icon(Icons.emoji_events, color: Colors.amber),
                ),
              )
            ],
          ),
        ));
  }
}
