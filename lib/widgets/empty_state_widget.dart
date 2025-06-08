// lib/widgets/empty_state_widget.dart
import 'package:flutter/material.dart';
import '../config/app_config.dart';

class EmptyStateWidget extends StatelessWidget {
  final bool isSearching;

  const EmptyStateWidget({
    super.key,
    required this.isSearching,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school,
            size: AppConfig.iconSize,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            isSearching
                ? AppConfig.noSearchResultsMessage
                : AppConfig.noStudentsMessage,
            textAlign: TextAlign.center,
            style: AppConfig.emptyStateTextStyle,
          ),
        ],
      ),
    );
  }
}