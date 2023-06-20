import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../helpers/database_helper.dart';
import '../models/task_model.dart';
import '../views/home_screen.dart';
import 'home_controller.dart';

class AddTaskController extends GetxController {
  final homeC = Get.put(HomeController());
  final _formKey = GlobalKey<FormState>();
  final taskList = RxList([]);
  final title = RxString('');
  final description = RxString('');
  final priority = RxString('');
  DateTime date = DateTime.now();
  TextEditingController dateController = TextEditingController();
  final titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final DateFormat dateFormatter = DateFormat('MMM dd, yyyy');
  final List<String> priorities = ['Low', 'Medium', 'High'];


  delete(id) {
   //  DatabaseHelper.instance.deleteTask(1);
     DatabaseHelper.instance.delete(id).then((value) {
       titleController.text = '';
       descriptionController.text = '';
       date = DateTime.now();
       Get.back();
     });
    Get.back();
    homeC.getData();

    Toast.show("Task Deleted",
        duration: Toast.lengthShort, gravity: Toast.bottom);
  }

  updateTask(id) {
    Task task = Task(
        title: titleController.text,
        descriptio: descriptionController.text,
        date: date,
        priority: priority.value);
    if (task != null) {
      task.status = 0;

      DatabaseHelper.instance.update(id).then((value) {
        titleController.text = '';
        descriptionController.text = '';
        date = DateTime.now();
        Get.back();
      });
      //
      Toast.show("Task Updated",
          duration: Toast.lengthShort, gravity: Toast.bottom);
    }
    // }
    Get.put(const HomeScreen());
    homeC.getData();
  }



  submit() {
    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState?.save();
    // print('$title, $date, $priority');

    Task task = Task(
        title: titleController.text,
        descriptio: descriptionController.text,
        date: date,
        priority: priority.value);
    if (task != null) {
      // Insert the task to our user's database
      task.status = 0;
      //DatabaseHelper.instance.insertTask(task);

      DatabaseHelper.instance.insert(task).then((value) {
        titleController.text = '';
        descriptionController.text = '';
        date = DateTime.now();
      });
      //
      Toast.show("New Task Added",
          duration: Toast.lengthLong, gravity: Toast.center);

      //  Toast.show("New Task Added",duration: Toast.lengthShort, gravity: Toast.bottom);
    }
    // else {
    //   // Update the task
    //   task.id = task.id;
    //   task.status = task.status;
    //   DatabaseHelper.instance.updateTask(task);
    //
    // }
    Get.put(const HomeScreen());
    homeC.getData();
  }
}
