// lib/widgets/search_bar_widget.dart
import 'package:flutter/material.dart';
import '../config/app_config.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConfig.defaultPadding),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: AppConfig.searchHint,
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onChanged: onChanged,
      ),
    );
  }
}