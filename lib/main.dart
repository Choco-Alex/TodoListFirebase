import 'package:firebase_app_web/pages/add_todo.dart';
import 'package:firebase_app_web/pages/home.dart';
import 'package:firebase_app_web/pages/login.dart';
import 'package:firebase_app_web/pages/profile.dart';
import 'package:firebase_app_web/pages/signUp.dart';
import 'package:firebase_app_web/pages/view_data.dart';
import 'package:firebase_app_web/phone_auth.dart';
import 'package:firebase_app_web/services/Auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = SignUpPage();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = MyHomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/Home',
      getPages: [
        GetPage(name: '/Home', page: () => MyHomePage()),
        GetPage(name: '/Login', page: () => LoginPage()),
        GetPage(name: '/SignUp', page: () => SignUpPage()),
        GetPage(name: '/Profile', page: () => ProfilePage()),
        GetPage(name: '/AddTodo', page: () => AddTodoPage()),
        GetPage(name: '/ViewData', page: () => ViewDataPage()),
        GetPage(name: '/PhoneAuth', page: () => Phone_auth_Page()),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController pageController = PageController(initialPage: 0);
  late int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      extendBody: true,
      body: PageView(
        controller: pageController,
        children: <Widget>[
          Center(
            child: HomePage(),
          ),
          Center(
            child: ProfilePage(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.withOpacity(0.7),
        unselectedFontSize: 14,
        onTap: (index) {
          setState(
            () {
              _selectedIndex = index;
              pageController.jumpToPage(index);
            },
          );
        },
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: InkWell(
              onTap: () {
                Get.to(AddTodoPage());
              },
              child: Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigoAccent,
                      Colors.purple,
                    ],
                  ),
                ),
                child: Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
