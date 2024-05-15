import 'package:get/get.dart';

class AddTodoController extends GetxController {
  String type = "";
  String category = "";
  String state = "";
  void tasktypeSelect(String label, int color) {
    type = label;
    update();
  }

  void categorytypeSelect(String label, int color) {
    category = label;
    update();
  }

  void taskStateSelect(String label, int color) {
    state = label;
    update();
  }
}
