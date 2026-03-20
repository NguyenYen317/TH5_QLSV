import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/student_service.dart';

class StudentProvider with ChangeNotifier {
  final StudentService _studentService = StudentService();
  List<Student> _students = [];
  bool _isLoading = false;

  List<Student> get students => _students;
  bool get isLoading => _isLoading;

  Future<void> loadStudents() async {
    _isLoading = true;
    notifyListeners();
    _students = await _studentService.getAllStudents();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addStudent(Student student) async {
    await _studentService.addStudent(student);
    await loadStudents();
  }

  Future<void> updateStudent(Student student) async {
    await _studentService.updateStudent(student);
    await loadStudents();
  }

  Future<void> deleteStudent(String id) async {
    await _studentService.deleteStudent(id);
    await loadStudents();
  }

  // Dashboard Statistics
  int get totalStudents => _students.length;

  Map<String, int> get studentsByClass {
    Map<String, int> stats = {};
    for (var s in _students) {
      stats[s.className] = (stats[s.className] ?? 0) + 1;
    }
    return stats;
  }

  Map<String, int> get studentsByMajor {
    Map<String, int> stats = {};
    for (var s in _students) {
      stats[s.major] = (stats[s.major] ?? 0) + 1;
    }
    return stats;
  }

  // Search, Filter and Sort
  List<Student> filterStudents({
    String query = '',
    String? className,
    String? major,
    String sortBy = 'name_asc',
  }) {
    List<Student> filtered = _students.where((s) {
      final matchesQuery = s.name.toLowerCase().contains(query.toLowerCase()) ||
          s.id.toLowerCase().contains(query.toLowerCase());
      final matchesClass = className == null || s.className == className;
      final matchesMajor = major == null || s.major == major;
      return matchesQuery && matchesClass && matchesMajor;
    }).toList();

    switch (sortBy) {
      case 'name_asc':
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'name_desc':
        filtered.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'gpa_asc':
        filtered.sort((a, b) => a.gpa.compareTo(b.gpa));
        break;
      case 'gpa_desc':
        filtered.sort((a, b) => b.gpa.compareTo(a.gpa));
        break;
    }
    return filtered;
  }
}
