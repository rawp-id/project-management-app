import 'package:flutter/material.dart';
import 'package:project_app/models/project.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Project project = Project();

  Future<int> printCountProject() async {
    try {
      final count = await project.getProjectCount();
      print('Project count: $count');
      return count;
    } catch (e) {
      print('Error fetching Project count: $e');
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Hello, RAWP!', style: TextStyle(fontSize: 20)),
                        FutureBuilder<int>(
                          future: printCountProject(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // return CircularProgressIndicator();
                              return SizedBox();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text(
                                'Your\nProjects (${snapshot.data})',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 43),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/foto.jpg',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/add');
                    },
                    child: Container(
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
                            'Create New Project',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Replaced Expanded with Flexible or just removed it.
                  FutureBuilder<List<Project>>(
                    future: project.getAllProject(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        final projects = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: projects.length,
                          itemBuilder: (context, index) {
                            final project = projects[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/show');
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Project Name',
                                          style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('Project Description'),
                                        SizedBox(height: 70),
                                        Row(
                                          children: [
                                            CircularProgressIndicator(
                                              value: 0.5,
                                              backgroundColor:
                                                  Colors.grey.withOpacity(0.1),
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.blue),
                                              strokeWidth: 10,
                                            ),
                                            SizedBox(width: 20),
                                            Text(
                                              '5/10 Tasks',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 20),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.blue),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 20),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
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
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          },
                        );
                      } else {
                        return Text('No data available');
                      }
                    },
                  ),

                  SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/show');
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
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
                            'Project Name',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Project Description'),
                          SizedBox(height: 70),
                          Row(
                            children: [
                              CircularProgressIndicator(
                                value: 0.5,
                                backgroundColor: Colors.grey.withOpacity(0.1),
                                valueColor: AlwaysStoppedAnimation(Colors.blue),
                                strokeWidth: 10,
                              ),
                              SizedBox(width: 20),
                              Text(
                                '5/10 Tasks',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
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
                                          border:
                                              Border.all(color: Colors.blue),
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
