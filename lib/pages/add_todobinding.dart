import 'package:firebase_app_web/pages/add_todoctrl.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTodoController>(() => AddTodoController());
  }
}
