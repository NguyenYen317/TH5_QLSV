import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/student_provider.dart';
import '../../models/student.dart';
import '../student/add_edit_student_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';
  String? _selectedClass;
  String? _selectedMajor;
  String _sortBy = 'name_asc';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentProvider>(context);
    final classes = provider.studentsByClass.keys.toList();
    final majors = provider.studentsByMajor.keys.toList();
    
    final filteredStudents = provider.filterStudents(
      query: _query,
      className: _selectedClass,
      major: _selectedMajor,
      sortBy: _sortBy,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm kiếm & Lọc'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildSearchAndFilterHeader(classes, majors),
          Expanded(
            child: filteredStudents.isEmpty
                ? const Center(child: Text('Không tìm thấy sinh viên nào'))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredStudents.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final student = filteredStudents[index];
                      return _buildStudentTile(context, student, provider);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterHeader(List<String> classes, List<String> majors) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue.shade50,
      child: Column(
        children: [
          TextField(
            onChanged: (value) => setState(() => _query = value),
            decoration: InputDecoration(
              hintText: 'Tìm theo tên hoặc ID',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  value: _selectedClass,
                  hint: 'Lớp',
                  items: classes,
                  onChanged: (val) => setState(() => _selectedClass = val),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDropdown(
                  value: _selectedMajor,
                  hint: 'Ngành',
                  items: majors,
                  onChanged: (val) => setState(() => _selectedMajor = val),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('Sắp xếp:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Expanded(
                child: _buildDropdown(
                  value: _sortBy,
                  items: const ['name_asc', 'name_desc', 'gpa_asc', 'gpa_desc'],
                  itemLabels: {
                    'name_asc': 'Tên A-Z',
                    'name_desc': 'Tên Z-A',
                    'gpa_asc': 'GPA thấp -> cao',
                    'gpa_desc': 'GPA cao -> thấp',
                  },
                  onChanged: (val) => setState(() => _sortBy = val!),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.blue),
                onPressed: () {
                  setState(() {
                    _query = '';
                    _selectedClass = null;
                    _selectedMajor = null;
                    _sortBy = 'name_asc';
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required dynamic value,
    String? hint,
    required List<String> items,
    Map<String, String>? itemLabels,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: hint != null ? Text(hint) : null,
          isExpanded: true,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(itemLabels?[item] ?? item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildStudentTile(BuildContext context, Student student, StudentProvider provider) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text(student.name[0].toUpperCase()),
        ),
        title: Text(student.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${student.id} - ${student.className} - GPA: ${student.gpa}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditStudentScreen(student: student),
            ),
          );
        },
      ),
    );
  }
}
