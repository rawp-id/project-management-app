import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_app/models/project.dart';
import 'package:project_app/models/task.dart';

class ShowView extends StatefulWidget {
  const ShowView({super.key});

  @override
  _ShowViewState createState() => _ShowViewState();
}

class _ShowViewState extends State<ShowView> {
  final Project project = Project();
  final Task task = Task();
  dynamic id;
  String selectedStatus = 'In Progress';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    id = args?['id'];
  }

  @override
  Widget build(BuildContext context) {
    // print(projectData);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Detail Project'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder<List<Project>>(
              future: project.getProjectById(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                  // return SizedBox();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final projects = snapshot.data!;
                  final project = projects.first;
                  return Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${project.name}',
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                  Text('${project.description}'),
                                ],
                              ),
                            ),
                            const SizedBox(width: 30),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return _dialogBuilder();
                              },
                            );
                          },
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Create New Task',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Text('No data available');
                }
              },
            ),
            // Container(
            //   padding: EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(40),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.blueGrey.withOpacity(0.2),
            //         spreadRadius: 3,
            //         blurRadius: 10,
            //         offset: Offset(0, 1),
            //       ),
            //     ],
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         children: [
            //           Expanded(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text('Project Name',
            //                     style: TextStyle(
            //                         fontSize: 30, fontWeight: FontWeight.bold)),
            //                 Text('Project Description'),
            //               ],
            //             ),
            //           ),
            //           const SizedBox(width: 30),
            //           Container(
            //             padding: EdgeInsets.all(10),
            //             margin: EdgeInsets.only(right: 5),
            //             decoration: BoxDecoration(
            //               color: Colors.blue,
            //               borderRadius: BorderRadius.circular(100),
            //             ),
            //             child: Icon(
            //               Icons.more_horiz,
            //               color: Colors.white,
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(height: 40),
            //       GestureDetector(
            //         onTap: () {
            //           showDialog(
            //             context: context,
            //             builder: (BuildContext context) {
            //               return _dialogBuilder();
            //             },
            //           );
            //         },
            //         child: Container(
            //           child: Column(
            //             children: <Widget>[
            //               Container(
            //                 padding: EdgeInsets.all(20),
            //                 decoration: BoxDecoration(
            //                   color: Colors.blue,
            //                   borderRadius: BorderRadius.circular(100),
            //                 ),
            //                 child: Row(
            //                   children: <Widget>[
            //                     Icon(
            //                       Icons.add,
            //                       color: Colors.white,
            //                     ),
            //                     SizedBox(width: 10),
            //                     Text(
            //                       'Create New Task',
            //                       style: TextStyle(color: Colors.white),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tasks',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Card(
                    color: Colors.white,
                    child: ExpansionTile(
                      title: Text('Task 1'),
                      subtitle: Text('Task Description'),
                      children: [
                        ListTile(
                          title: Text('Status'),
                          trailing: DropdownButton<String>(
                            value: selectedStatus,
                            onChanged: (String? value) {
                              setState(() {
                                selectedStatus = value!;
                              });
                            },
                            items: <String>['In Progress', 'Done', 'Pending']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        ListTile(
                          title: Text('Due Date'),
                          trailing: Text('2021-12-31'),
                        ),
                        ListTile(
                          title: Text('Assignee'),
                          trailing: Text('User 1'),
                        ),
                        ListTile(
                          title: Text('Description'),
                          subtitle: Text('Task Description'),
                        ),
                        ListTile(
                          title: Text('Attachment'),
                          trailing: Icon(Icons.attach_file),
                        ),
                        ListTile(
                          title: Text('Comment'),
                          trailing: Icon(Icons.comment),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

AlertDialog _dialogBuilder() {
  return AlertDialog(
    title: const Text('Basic dialog title'),
    content: const Text(
      'A dialog is a type of modal window that\n'
      'appears in front of app content to\n'
      'provide critical information, or prompt\n'
      'for a decision to be made.',
    ),
  );
}
