import 'package:flutter/material.dart';
import 'package:project_app/models/project.dart';
import 'package:project_app/models/task.dart';
import 'package:project_app/models/user.dart';
import 'package:project_app/services/api.dart';

class ApiTest extends StatelessWidget {
  final ApiService apiService = ApiService();
  final Project project = Project();
  final User user = User();
  final Task task = Task();

  Future<int> printTaskCount(int id) async {
    try {
      final count = await task.getTaskCountByProject(id);
      print('Task count: $count');
      return count;
    } catch (e) {
      print('Error fetching task count: $e');
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // apiService.auth('my_app', 'my_app@123');

    // printTaskCount();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kriingg API Example with Auth'),
        ),
        body: Column(
          children: [
            // FutureBuilder<int>(
            //   future: printTaskCount(11), // Memanggil fungsi asynchronous
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return CircularProgressIndicator(); // Loading spinner
            //     } else if (snapshot.hasError) {
            //       return Text(
            //           'Error: ${snapshot.error}'); // Menampilkan error jika ada
            //     } else {
            //       return Text(
            //           'Task count: ${snapshot.data}'); // Menampilkan hasil
            //     }
            //   },
            // ),
            // Expanded(
            //   child: Center(
            //     child: FutureBuilder<List<User>>(
            //       future: user.getUser(),
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return CircularProgressIndicator();
            //         } else if (snapshot.hasError) {
            //           return Text('Error: ${snapshot.error}');
            //         } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            //           final users = snapshot.data!;
            //           return ListView.builder(
            //             itemCount: users.length,
            //             itemBuilder: (context, index) {
            //               final user = users[index];
            //               return ListTile(
            //                 title: Text('ID: ${user.id}'),
            //                 subtitle: Text('Name: ${user.name}\nUsername: ${user.username}\nEmail: ${user.email}\nRole: ${user.role}\nLDAP: ${user.isLdapUser}'),
            //               );
            //             },
            //           );
            //         } else {
            //           return Text('No data available');
            //         }
            //       },
            //     ),
            //   ),
            // ),
            // Expanded(
            //   child: Center(
            //     child: FutureBuilder<List<Project>>(
            //       future: project.fetchProjects(),
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return CircularProgressIndicator();
            //         } else if (snapshot.hasError) {
            //           return Text('Error: ${snapshot.error}');
            //         } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            //           final projects = snapshot.data!;
            //           return ListView.builder(
            //             itemCount: projects.length,
            //             itemBuilder: (context, index) {
            //               final project = projects[index];
            //               return ListTile(
            //                 title: Text('ID: ${project.id}'),
            //                 subtitle: Text('Name: ${project.name}'),
            //               );
            //             },
            //           );
            //         } else {
            //           return Text('No data available');
            //         }
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
