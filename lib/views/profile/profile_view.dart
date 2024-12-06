import 'package:flutter/material.dart';
import 'package:project_app/models/user.dart';
import 'package:project_app/services/api.dart';
import 'package:project_app/views/profile/profile_view.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      List<User> users = await User().getUser();
      setState(() {
        user = users.isNotEmpty ? users[0] : null;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error
      print('Error fetching user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : user == null
              ? Center(child: Text('No user found'))
              : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (user!.avatarPath != null)
                      CircleAvatar(
                        backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                        radius: 50,
                      ),
                    SizedBox(height: 16),
                    Text('Name: ${user!.name ?? 'N/A'}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Username: ${user!.username ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text('Email: ${user!.email ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text('Role: ${user!.role ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                  ],
                ),
              ),
    );
  }
}