import 'package:get/get.dart';
import '../controllers/add_task_controller.dart';
import '../controllers/home_controller.dart';

class Base {
  final homeC = Get.put(HomeController());
  final addC = Get.put(AddTaskController());
}
