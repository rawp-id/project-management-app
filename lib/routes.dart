import 'package:flutter/material.dart';
import 'package:project_app/views/auth/login_view.dart';
import 'package:project_app/views/auth/register_view.dart';
import 'package:project_app/views/home_view.dart';
import 'package:project_app/views/profile/profile_view.dart';
import 'package:project_app/views/project/add_view.dart';
import 'package:project_app/views/project/show_view.dart';
  
Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => LoginView(),
  '/register': (context) => RegisterView(),
  '/home': (context) => HomeView(),
  '/add': (context) => AddProjectView(),
  '/show': (context) => ShowView(),
  '/profile': (context) => ProfileView(),
};
