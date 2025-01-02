import 'package:flutter/material.dart';
import '../theme/color.dart';

class SidebarIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  const SidebarIcon({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.iconGrey,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: TextStyle(
              color: AppColors.iconGrey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
