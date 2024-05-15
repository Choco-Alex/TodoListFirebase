import 'package:firebase_app_web/pages/home.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final List<Select> selected = [];
  void onChange(int index) {
    selected[index].checkValue = !selected[index].checkValue;
    update();
  }
}
