import 'package:flutter/material.dart';
import '../screens/auth/login_page.dart';
import '../screens/auth/register_page.dart';
import '../screens/home/home_screen.dart';
import '../screens/student/student_list_screen.dart';
import '../screens/student/add_edit_student_screen.dart';
import '../screens/search/search_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String studentList = '/students';
  static const String addStudent = '/add-student';
  static const String editStudent = '/edit-student';
  static const String search = '/search';

  static Map<String, WidgetBuilder> get routes => {
        login: (context) => const LoginPage(),
        register: (context) => const RegisterPage(),
        home: (context) => const HomeScreen(),
        studentList: (context) => const StudentListScreen(),
        addStudent: (context) => const AddEditStudentScreen(),
        search: (context) => const SearchScreen(),
      };
}
