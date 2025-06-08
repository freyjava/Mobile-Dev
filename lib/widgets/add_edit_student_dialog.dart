// lib/widgets/add_edit_student_dialog.dart
import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/db_helper.dart';
import '../utils/validators.dart';
import '../config/app_config.dart';

class AddEditStudentDialog extends StatefulWidget {
  final Student? student;
  final Function(Student) onSave;

  const AddEditStudentDialog({
    super.key,
    this.student,
    required this.onSave,
  });

  @override
  State<AddEditStudentDialog> createState() => _AddEditStudentDialogState();
}

class _AddEditStudentDialogState extends State<AddEditStudentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _classController = TextEditingController();
  final _departmentController = TextEditingController();
  String _selectedGender = AppConfig.genderOptions.first;
  bool _isLoading = false;

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _populateFields();
    }
  }

  void _populateFields() {
    final student = widget.student!;
    _nameController.text = student.name;
    _emailController.text = student.email;
    _phoneController.text = student.phone;
    _classController.text = student.className;
    _departmentController.text = student.department;
    _selectedGender = student.gender;
  }

  Future<void> _saveStudent() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final student = Student(
        id: widget.student?.id,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        className: _classController.text.trim(),
        department: _departmentController.text.trim(),
        gender: _selectedGender,
        dateRegistered: widget.student?.dateRegistered ?? 
            DateTime.now().toString().split(' ')[0],
        present: widget.student?.present ?? false,
      );

      if (widget.student == null) {
        await _dbHelper.insertStudent(student);
      } else {
        await _dbHelper.updateStudent(student);
      }

      widget.onSave(student);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Error saving student: $e');
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppConfig.errorColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.student == null ? 'Add Student' : 'Edit Student'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Name *',
                validator: Validators.validateName,
              ),
              const SizedBox(height: AppConfig.formFieldSpacing),
              _buildTextField(
                controller: _emailController,
                label: 'Email *',
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
              ),
              const SizedBox(height: AppConfig.formFieldSpacing),
              _buildTextField(
                controller: _phoneController,
                label: 'Phone *',
                keyboardType: TextInputType.phone,
                validator: Validators.validatePhone,
              ),
              const SizedBox(height: AppConfig.formFieldSpacing),
              _buildTextField(
                controller: _classController,
                label: 'Class Name *',
                validator: Validators.validateClassName,
              ),
              const SizedBox(height: AppConfig.formFieldSpacing),
              _buildTextField(
                controller: _departmentController,
                label: 'Department *',
                validator: Validators.validateDepartment,
              ),
              const SizedBox(height: AppConfig.formFieldSpacing),
              _buildGenderDropdown(),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _saveStudent,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(widget.student == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: const InputDecoration(
        labelText: 'Gender *',
        border: OutlineInputBorder(),
      ),
      items: AppConfig.genderOptions.map((gender) {
        return DropdownMenuItem(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      onChanged: (value) {
        setState(() => _selectedGender = value!);
      },
      validator: Validators.validateGender,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _classController.dispose();
    _departmentController.dispose();
    super.dispose();
  }
}