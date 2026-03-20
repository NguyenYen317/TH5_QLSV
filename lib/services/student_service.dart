import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/student.dart';

class StudentService {
  static const String _keyStudents = 'students_list';

  Future<List<Student>> getAllStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final String? studentsJson = prefs.getString(_keyStudents);
    if (studentsJson == null) return [];
    
    final List<dynamic> decoded = jsonDecode(studentsJson);
    return decoded.map((item) => Student.fromJson(item)).toList();
  }

  Future<void> saveStudents(List<Student> students) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(students.map((s) => s.toJson()).toList());
    await prefs.setString(_keyStudents, encoded);
  }

  Future<void> addStudent(Student student) async {
    final students = await getAllStudents();
    students.add(student);
    await saveStudents(students);
  }

  Future<void> updateStudent(Student updatedStudent) async {
    final students = await getAllStudents();
    final index = students.indexWhere((s) => s.id == updatedStudent.id);
    if (index != -1) {
      students[index] = updatedStudent;
      await saveStudents(students);
    }
  }

  Future<void> deleteStudent(String id) async {
    final students = await getAllStudents();
    students.removeWhere((s) => s.id == id);
    await saveStudents(students);
  }
}
