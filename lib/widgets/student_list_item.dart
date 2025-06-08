// lib/widgets/student_list_item.dart
import 'package:flutter/material.dart';
import '../models/student.dart';
import '../config/app_config.dart';

class StudentListItem extends StatelessWidget {
  final Student student;
  final VoidCallback onToggleAttendance;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const StudentListItem({
    super.key,
    required this.student,
    required this.onToggleAttendance,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConfig.cardMarginHorizontal,
        vertical: AppConfig.cardMarginVertical,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: student.present
              ? AppConfig.presentColor
              : AppConfig.absentColor,
          child: Text(
            student.name[0].toUpperCase(),
            style: AppConfig.whiteTextStyle,
          ),
        ),
        title: Text(
          student.name,
          style: AppConfig.cardTitleStyle,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${student.className} - ${student.department}'),
            Text('${student.email} • ${student.phone}'),
            Text('Gender: ${student.gender}'),
            Text('Registered: ${student.dateRegistered}'),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'attendance',
              child: Row(
                children: [
                  Icon(
                    student.present ? Icons.close : Icons.check,
                  ),
                  const SizedBox(width: 8),
                  Text(student.present ? 'Mark Absent' : 'Mark Present'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: AppConfig.errorColor),
                  SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: AppConfig.errorColor)),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 'attendance':
                onToggleAttendance();
                break;
              case 'edit':
                onEdit();
                break;
              case 'delete':
                onDelete();
                break;
            }
          },
        ),
        isThreeLine: true,
      ),
    );
  }
}