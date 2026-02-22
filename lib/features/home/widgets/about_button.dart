import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';

class AboutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AboutButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'about_fab',
      onPressed: onPressed,
      backgroundColor: AppColors.secondaryColor,
      foregroundColor: Colors.white,
      mini: true,
      tooltip: 'About Us',
      child: const Icon(Icons.info_outline),
    );
  }
}
