import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class TagWidget extends StatelessWidget {
  final String tag;

  const TagWidget({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: AppColors.tertiaryLight,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          fontSize: 12.0,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
