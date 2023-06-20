import 'package:flutter/material.dart';

import '../config/base.dart';
import '../models/task_model.dart';

class UpdateTaskScreen extends StatefulWidget {
  final Task task;
  const UpdateTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> with Base {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        title: const Row(
          children: [
            Text(
              'Update Task',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        // actions: [
        //   IconButton(
        //       icon: Icon(
        //         Icons.info_outline,
        //         color: Colors.black,
        //       ),
        //       onPressed: () {}),
        // ],
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: TextFormField(
                        controller: addC.titleController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: const TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        // validator: 'Please enter a task title',
                        onSaved: (val) {
                          addC.titleController.text = val as String;
                        },
                        // initialValue:
                        //     widget.task.title != null ? widget.task.title : '',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: TextFormField(
                        controller: addC.descriptionController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: const TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        // validator: 'Please enter a task title',
                        onSaved: (val) {
                          addC.descriptionController.text = val as String;
                        },
                        // initialValue: widget.task.descriptio != null
                        //     ? widget.task.descriptio
                        //     : '',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: TextFormField(
                        readOnly: true,
                        controller: addC.dateController,
                        style: const TextStyle(fontSize: 18.0),
                        onTap: () async {
                          final DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: addC.date,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (date != null && date != addC.date) {
                            setState(() {
                              addC.date = date;
                            });
                            addC.dateController.text =
                                addC.dateFormatter.format(date);
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Date',
                          labelStyle: const TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      height: 60.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        onPressed: () async {
                          addC.updateTask(widget.task);
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      height: 60.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        onPressed: () async {
                          addC.delete(widget.task.id);
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
