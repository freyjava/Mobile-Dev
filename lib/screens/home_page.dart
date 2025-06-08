// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/db_helper.dart';
import '../config/app_config.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/student_list_item.dart';
import '../widgets/add_edit_student_dialog.dart';
import '../utils/dialog_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  List<Student> _students = [];
  List<Student> _filteredStudents = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    setState(() => _isLoading = true);
    try {
      final students = await _dbHelper.getAllStudents();
      setState(() {
        _students = students;
        _filteredStudents = students;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        DialogHelper.showSnackBar(context, 'Error loading students: $e', isError: true);
      }
    }
  }

  void _filterStudents(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredStudents = _students;
      } else {
        _filteredStudents = _students
            .where((student) =>
                student.name.toLowerCase().contains(query.toLowerCase()) ||
                student.email.toLowerCase().contains(query.toLowerCase()) ||
                student.className.toLowerCase().contains(query.toLowerCase()) ||
                student.department.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> _toggleAttendance(Student student) async {
    try {
      await _dbHelper.toggleAttendance(student.id!, !student.present);
      _loadStudents();
      if (mounted) {
        DialogHelper.showSnackBar(
          context,
          AppConfig.getAttendanceMessage(student.name, !student.present),
        );
      }
    } catch (e) {
      if (mounted) {
        DialogHelper.showSnackBar(context, 'Error updating attendance: $e', isError: true);
      }
    }
  }

  Future<void> _deleteStudent(Student student) async {
    final confirmed = await DialogHelper.showConfirmDialog(
      context,
      'Delete Student',
      AppConfig.getDeleteConfirmMessage(student.name),
    );

    if (confirmed) {
      try {
        await _dbHelper.deleteStudent(student.id!);
        _loadStudents();
        if (mounted) {
          DialogHelper.showSnackBar(
            context,
            AppConfig.getDeleteSuccessMessage(student.name),
          );
        }
      } catch (e) {
        if (mounted) {
          DialogHelper.showSnackBar(context, 'Error deleting student: $e', isError: true);
        }
      }
    }
  }

  void _showAddEditDialog([Student? student]) {
    showDialog(
      context: context,
      builder: (context) => AddEditStudentDialog(
        student: student,
        onSave: (savedStudent) {
          _loadStudents();
          if (mounted) {
            DialogHelper.showSnackBar(
              context,
              student == null
                  ? AppConfig.getAddSuccessMessage(savedStudent.name)
                  : AppConfig.getUpdateSuccessMessage(savedStudent.name),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConfig.appTitle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadStudents,
          ),
        ],
      ),
      body: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            onChanged: _filterStudents,
          ),
          Expanded(
            child: _buildStudentList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStudentList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_filteredStudents.isEmpty) {
      return EmptyStateWidget(
        isSearching: _searchController.text.isNotEmpty,
      );
    }

    return ListView.builder(
      itemCount: _filteredStudents.length,
      itemBuilder: (context, index) {
        final student = _filteredStudents[index];
        return StudentListItem(
          student: student,
          onToggleAttendance: () => _toggleAttendance(student),
          onEdit: () => _showAddEditDialog(student),
          onDelete: () => _deleteStudent(student),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}