import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/student.dart';
import '../../providers/student_provider.dart';
import 'add_edit_student_screen.dart';

class StudentDetailScreen extends StatelessWidget {
  final String studentId;

  const StudentDetailScreen({Key? key, required this.studentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sinh viên'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          Consumer<StudentProvider>(
            builder: (context, provider, child) {
              final student = provider.students.firstWhere((s) => s.id == studentId);
              return IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditStudentScreen(student: student),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<StudentProvider>(
        builder: (context, provider, child) {
          // Lấy lại dữ liệu mới nhất từ Provider dựa trên ID
          final student = provider.students.firstWhere(
            (s) => s.id == studentId,
            orElse: () => Student(id: '', name: '', className: '', major: '', gpa: 0),
          );

          if (student.id.isEmpty) {
            return const Center(child: Text('Không tìm thấy sinh viên'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  student.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Mã SV: ${student.id}',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 30),
                _buildInfoCard(Icons.school, 'Lớp', student.className),
                _buildInfoCard(Icons.book, 'Ngành học', student.major),
                _buildInfoCard(Icons.star, 'GPA', student.gpa.toString(), color: _getGpaColor(student.gpa)),
                const SizedBox(height: 40),
                const Divider(),
                const Text(
                  'Thông tin học tập được cập nhật từ hệ thống quản lý.',
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value, {Color? color}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: color ?? Colors.blueAccent),
        title: Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        subtitle: Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }

  Color _getGpaColor(double gpa) {
    if (gpa >= 3.6) return Colors.green;
    if (gpa >= 3.2) return Colors.blue;
    if (gpa >= 2.5) return Colors.orange;
    return Colors.red;
  }
}
