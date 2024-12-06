import 'package:flutter/material.dart';
import 'package:project_app/models/project.dart';
import 'package:project_app/models/task.dart';
import 'package:project_app/models/user.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final projectCount = await Project().getProjectCount();
      final users = await User().getUser();
      final projects = await Project().getAllProject();
      return {
        'projectCount': projectCount,
        'users': users,
        'projects': projects,
      };
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            final users = data['users'] as List<User>;
            final projects = data['projects'] as List<Project>;
            final projectCount = data['projectCount'] as int;

            return SingleChildScrollView(
              child: Column(
                children: [
                  // User Greeting
                  ...users.map((user) {
                    return Container(
                      margin: EdgeInsets.only(
                          top: 50, left: 30, right: 30, bottom: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello, ${user.name}!',
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Your\nProjects ($projectCount)',
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/profile');
                            },
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  // Create New Project Button
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/add');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            'Create New Project',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Project List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/show', arguments: {
                            'id': project.id,
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${project.name}',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('${project.description}'),
                              SizedBox(height: 70),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.task, 
                                    color: Colors.blue,
                                    size: 40,
                                    ),
                                  const SizedBox(width: 10),
                                  FutureBuilder<int>(
                                    future: Task()
                                        .getTaskCountByProject(project.id!),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Text('...');
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        return Text(
                                          '${snapshot.data} Tasks',
                                          style: const TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 70),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blue),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Icon(
                                              Icons.more_horiz,
                                              color: Colors.blue,
                                              size: 35,
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 35,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
