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

  // updateTaskList() {
  //   taskLists = DatabaseHelper.instance.getTaskList();
  //   if (taskLists != null) {
  //     // taskList.value.addAll(taskLists);
  //   }
  // }

  ///Fetch data from database
  getData() async {
    var dbHelper = DatabaseHelper();
    await dbHelper.getAllUsers().then((value) {
      list  = value as List<Task>;

      if(list != null){
        taskList.addAll(list);
      }
    });

    return list;
  }
}
