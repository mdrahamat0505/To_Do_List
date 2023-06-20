import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_repositories/views/settings_screen.dart';
import 'package:github_repositories/views/update_task_screen.dart';
import 'package:toast/toast.dart';

import '../config/base.dart';
import '../helpers/database_helper.dart';
import 'add_task_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Base {
  @override
  void initState() {
    super.initState();
    homeC.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: const Icon(Icons.add_outlined),

        onPressed: () {
          Get.to(() => const AddTaskScreen());

        },
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        leading: const IconButton(
            icon: Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey,
            ),
            onPressed: null),
        title: const Row(
          children: [
            Text(
              "To Do",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                letterSpacing: -1.2,
              ),
            ),
            Text(
              "App",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
              ),
            )
          ],
        ),
        centerTitle: false,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.all(0),
            child: IconButton(
                icon: const Icon(Icons.history_outlined),
                iconSize: 25.0,
                color: Colors.black,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()))),
          ),
          Container(
            margin: const EdgeInsets.all(6.0),
            child: IconButton(
                icon: const Icon(Icons.settings_outlined),
                iconSize: 25.0,
                color: Colors.black,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Settings()))),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        itemCount: homeC.taskList.value.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color.fromRGBO(240, 240, 240, 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Center(
                      child: Text(
                        'You have [ ${homeC.taskList.value.length}, ] pending task out of [ ${homeC.taskList.value.length} ]',
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    '${homeC.taskList.value[index].title}',
                    style: TextStyle(
                      fontSize: 18.0,
                      decoration: homeC.taskList.value[index].status == 0 ? TextDecoration.none : TextDecoration.lineThrough,
                    ),
                  ),
                  subtitle: Text(
                    '${homeC.dateFormatter.format(homeC.taskList.value[index].date as DateTime)} • ${homeC.taskList.value[index].priority}',
                    style: TextStyle(
                      fontSize: 15.0,
                      decoration: homeC.taskList.value[index].status == 0 ? TextDecoration.none : TextDecoration.lineThrough,
                    ),
                  ),
                  trailing: Checkbox(
                    onChanged: (value) {
                      homeC.taskList.value[index].status = true ? 1 : 0;
                      DatabaseHelper.instance.update(homeC.taskList.value[index]);

                      Toast.show("Task Completed", duration: Toast.lengthShort, gravity: Toast.bottom);
                      homeC.getData();
                    },
                    activeColor: Theme.of(context).primaryColor,
                    value: homeC.taskList.value[index].status == 1 ? true : false,
                  ),
                  onTap: () {
                    Get.to(() => UpdateTaskScreen(task: homeC.taskList.value[index]));
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
