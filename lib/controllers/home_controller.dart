import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../helpers/database_helper.dart';
import '../models/task_model.dart';

class HomeController extends GetxController {
  final taskList = RxList<Task>([]);
  final DateFormat dateFormatter = DateFormat('MMM dd, yyyy');
  late List<Task> list = [];

  Future<List<Task>>? taskLists;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    //selectNewsCheck();
    ///updateTaskList();
    getData();
    super.onReady();
  }

  ///Fetch data from database
  getData() async {
    var dbHelper = DatabaseHelper();
    await dbHelper.getAllUsers().then((value) {
      list.addAll(value as List<Task>);

      if(list != null){
        taskList.value.addAll(list);
      }
    });

    return list;
  }
}
