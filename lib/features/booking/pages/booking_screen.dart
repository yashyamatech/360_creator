import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/validators.dart';
import '../../../shared/widgets/custom_button.dart';
import '../store/booking_store.dart';

class BookingScreen extends StatefulWidget {
  final String? videoId;

  const BookingScreen({Key? key, this.videoId}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _requirementsController;
  late TextEditingController _budgetController;
  late TextEditingController _timelineController;

  late BookingStore _bookingStore;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _requirementsController = TextEditingController();
    _budgetController = TextEditingController();
    _timelineController = TextEditingController();

    _bookingStore = context.read<BookingStore>();
    if (widget.videoId != null) {
      _bookingStore.selectVideo(widget.videoId!);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _requirementsController.dispose();
    _budgetController.dispose();
    _timelineController.dispose();
    super.dispose();
  }

  void _submitBooking() {
    if (_formKey.currentState!.validate()) {
      _bookingStore.submitBooking(
        clientName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        projectRequirements: _requirementsController.text.trim().isEmpty
            ? null
            : _requirementsController.text.trim(),
        budget: _budgetController.text.trim().isEmpty
            ? null
            : _budgetController.text.trim(),
        timeline: _timelineController.text.trim().isEmpty
            ? null
            : _timelineController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Project'),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () => context.pop(),
        ),
      ),
      body: Observer(
        builder: (_) {
          if (_bookingStore.isSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking submitted successfully!'),
                  backgroundColor: AppColors.successColor,
                  duration: Duration(seconds: 3),
                ),
              );
              _bookingStore.resetForm();
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
                    'Book Your Project',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Let\'s bring your vision to life. Share the details below.',
                    style: TextStyle(color: AppColors.darkGrayColor),
                  ),
                  if (widget.videoId != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.secondaryColor.withOpacity(0.3),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.video_library_outlined,
                            color: AppColors.secondaryColor,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Reference video attached',
                            style: TextStyle(color: AppColors.secondaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                      labelText: 'Phone Number (Optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.phone_outlined),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _requirementsController,
                    decoration: InputDecoration(
                      labelText: 'Project Requirements (Optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.description_outlined),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _budgetController,
                    decoration: InputDecoration(
                      labelText: 'Budget (Optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.attach_money),
                      hintText: 'e.g. \$2000',
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
                      hintText: 'e.g. 1 month',
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_bookingStore.error != null)
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
                                _bookingStore.error!,
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
                    label: 'Submit Booking',
                    onPressed: _submitBooking,
                    isLoading: _bookingStore.isLoading,
                    icon: Icons.calendar_month,
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
