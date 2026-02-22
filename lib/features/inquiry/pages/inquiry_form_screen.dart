import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/validators.dart';
import '../../../shared/widgets/custom_button.dart';
import '../store/inquiry_store.dart';

class InquiryFormScreen extends StatefulWidget {
  const InquiryFormScreen({Key? key}) : super(key: key);

  @override
  State<InquiryFormScreen> createState() => _InquiryFormScreenState();
}

class _InquiryFormScreenState extends State<InquiryFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _messageController;
  late TextEditingController _budgetController;
  late TextEditingController _timelineController;

  String? _selectedProjectType;
  late InquiryStore _inquiryStore;

  final List<String> projectTypes = [
    'Video Creation',
    'Video Editing',
    'Both',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _messageController = TextEditingController();
    _budgetController = TextEditingController();
    _timelineController = TextEditingController();
    _inquiryStore = context.read<InquiryStore>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    _budgetController.dispose();
    _timelineController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedProjectType != null) {
      _inquiryStore.submitInquiry(
        clientName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        projectType: _selectedProjectType!,
        message: _messageController.text.trim(),
        budgetRange: _budgetController.text.trim().isEmpty
            ? null
            : _budgetController.text.trim(),
        timeline: _timelineController.text.trim().isEmpty
            ? null
            : _timelineController.text.trim(),
      );
    } else if (_selectedProjectType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a project type'),
          backgroundColor: AppColors.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make an Inquiry'),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () => context.pop(),
        ),
      ),
      body: Observer(
        builder: (_) {
          if (_inquiryStore.isSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Inquiry submitted successfully!'),
                  backgroundColor: AppColors.successColor,
                  duration: Duration(seconds: 3),
                ),
              );
              _inquiryStore.resetForm();
              context.pop();
            });
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Tell us about your project',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Fill in the details below and we\'ll get back to you shortly.',
                    style: TextStyle(color: AppColors.darkGrayColor),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                    textCapitalization: TextCapitalization.words,
                    validator: (value) => Validators.validateName(value),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => Validators.validateEmail(value),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.phone_outlined),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) => Validators.validatePhone(value),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedProjectType,
                    decoration: InputDecoration(
                      labelText: 'Project Type *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.category_outlined),
                    ),
                    items: projectTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => _selectedProjectType = value);
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a project type';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Project Details *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.description_outlined),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 4,
                    validator: (value) => Validators.validateMessage(value),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _budgetController,
                    decoration: InputDecoration(
                      labelText: 'Budget Range (Optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.attach_money),
                      hintText: 'e.g. \$1000 - \$5000',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _timelineController,
                    decoration: InputDecoration(
                      labelText: 'Timeline (Optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.calendar_today_outlined),
                      hintText: 'e.g. 2-4 weeks',
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_inquiryStore.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.errorColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.errorColor.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: AppColors.errorColor,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _inquiryStore.error!,
                                style: const TextStyle(
                                  color: AppColors.errorColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  CustomButton(
                    label: 'Submit Inquiry',
                    onPressed: _submitForm,
                    isLoading: _inquiryStore.isLoading,
                    icon: Icons.send,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
