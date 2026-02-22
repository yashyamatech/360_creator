import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';

class InquiryFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const InquiryFAB({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: 'inquiry_fab',
      onPressed: onPressed,
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      icon: const Icon(Icons.mail_outline),
      label: const Text(
        'Inquiry',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
