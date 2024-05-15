import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_web/pages/todo_card.dart';
import 'package:firebase_app_web/pages/view_data.dart';
import 'package:firebase_app_web/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:firebase_app_web/pages/homeCtrl.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  final AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();

  final PageController pageController = PageController(initialPage: 0);
  final int i = 0;
  final date = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text(
            "Liste des taches",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.enc"),
            ),
            SizedBox(
              width: 15,
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(35),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Aujourd'hui Le",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigoAccent,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      date.toString(),
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigoAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                IconData iconData;
                Color iconColor;

                Map<String, dynamic> document =
                    snapshot.data?.docs[index].data() as Map<String, dynamic>;
                switch (document["category"]) {
                  case "Work":
                    iconData = Icons.run_circle_outlined;
                    iconColor = const Color.fromARGB(255, 128, 114, 113);
                    break;
                  case "Food":
                    iconData = Icons.local_grocery_store;
                    iconColor = Colors.green;
                    break;
                  case "Sport":
                    iconData = Icons.sports;
                    iconColor = Colors.blue;
                    break;
                  case "Coding":
                    iconData = Icons.computer;
                    iconColor = Colors.yellow;
                    break;
                  case "Love":
                    iconData = Icons.favorite;
                    iconColor = Colors.red;
                    break;
                  case "Perso":
                    iconData = Icons.person_3;
                    iconColor = Color.fromARGB(255, 59, 27, 199);
                    break;
                  case "Evenement":
                    iconData = Icons.sunny;
                    iconColor = Color.fromARGB(255, 228, 125, 8);
                    break;
                  case "TV":
                    iconData = Icons.dark_mode;
                    iconColor = Color.fromARGB(255, 14, 213, 228);
                    break;
                  case "School":
                    iconData = Icons.school;
                    iconColor = Colors.purple;
                    break;
                  default:
                    iconData = Icons.run_circle_outlined;
                    iconColor = Colors.orange;
                }
                controller.selected.add(Select(
                    id: snapshot.data?.docs[index].id, checkValue: false));
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => ViewDataPage(
                                  document: document,
                                  id: snapshot.data?.docs[index].id,
                                )));
                  },
                  child: TodoCard(
                    title: document["title"] == null
                        ? "hey there"
                        : document["title"],
                    check: controller.selected[index].checkValue,
                    iconBgColor: Colors.black,
                    iconColor: iconColor,
                    iconData: iconData,
                    index: index,
                    onChange: controller.onChange,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class Select {
  String? id;
  bool checkValue = false;
  Select({this.id, required this.checkValue});
}
//  IconButton(
//             onPressed: () async {
//               await authClass.logout();
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (builder) => SignUpPage()),
//                   (route) => false);
//             },
//             icon: Icon(
//               Icons.logout,
//               color: Colors.white,
//             ),
//           ),
