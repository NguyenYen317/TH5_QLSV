import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/student.dart';
import '../../providers/student_provider.dart';

class AddEditStudentScreen extends StatefulWidget {
  final Student? student;

  const AddEditStudentScreen({Key? key, this.student}) : super(key: key);

  @override
  State<AddEditStudentScreen> createState() => _AddEditStudentScreenState();
}

class _AddEditStudentScreenState extends State<AddEditStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _classController;
  late TextEditingController _majorController;
  late TextEditingController _gpaController;

  bool get isEdit => widget.student != null;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.student?.id ?? '');
    _nameController = TextEditingController(text: widget.student?.name ?? '');
    _classController = TextEditingController(text: widget.student?.className ?? '');
    _majorController = TextEditingController(text: widget.student?.major ?? '');
    _gpaController = TextEditingController(text: widget.student?.gpa.toString() ?? '');
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _classController.dispose();
    _majorController.dispose();
    _gpaController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final student = Student(
        id: _idController.text.trim(),
        name: _nameController.text.trim(),
        className: _classController.text.trim(),
        major: _majorController.text.trim(),
        gpa: double.parse(_gpaController.text.trim()),
      );

      final provider = Provider.of<StudentProvider>(context, listen: false);
      if (isEdit) {
        provider.updateStudent(student);
      } else {
        provider.addStudent(student);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Chỉnh sửa sinh viên' : 'Thêm sinh viên mới'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: _idController,
                label: 'Mã sinh viên',
                enabled: !isEdit,
                validator: (v) => v!.isEmpty ? 'Vui lòng nhập ID' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _nameController,
                label: 'Họ và tên',
                validator: (v) => v!.isEmpty ? 'Vui lòng nhập tên' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _classController,
                label: 'Lớp',
                validator: (v) => v!.isEmpty ? 'Vui lòng nhập lớp' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _majorController,
                label: 'Ngành học',
                validator: (v) => v!.isEmpty ? 'Vui lòng nhập ngành' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _gpaController,
                label: 'GPA',
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v!.isEmpty) return 'Vui lòng nhập GPA';
                  final gpa = double.tryParse(v);
                  if (gpa == null || gpa < 0 || gpa > 4.0) return 'GPA hợp lệ (0 - 4.0)';
                  return null;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: Text(
                    isEdit ? 'CẬP NHẬT' : 'THÊM MỚI',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: !enabled,
        fillColor: Colors.grey.shade100,
      ),
      validator: validator,
      enabled: enabled,
      keyboardType: keyboardType,
    );
  }
}
