import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import '../../store/inquiry_store.dart';
import '../../../../data/repositories/inquiry_repository.dart';
import '../../../../config/app_constants.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_app_bar.dart';

class InquiryFormScreen extends StatefulWidget {
  final String? referenceVideoId;
  final String? referenceVideoTitle;

  const InquiryFormScreen({
    super.key,
    this.referenceVideoId,
    this.referenceVideoTitle,
  });

  @override
  State<InquiryFormScreen> createState() => _InquiryFormScreenState();
}

class _InquiryFormScreenState extends State<InquiryFormScreen> {
  late final InquiryStore _store;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _store = InquiryStore(InquiryRepository());
    if (widget.referenceVideoTitle != null) {
      _store.setMessage(
        'I am interested in a project similar to "${widget.referenceVideoTitle}".\n\n',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: const CustomAppBar(
        title: 'Send Inquiry',
        showBackButton: true,
      ),
      body: Observer(
        builder: (_) {
          if (_store.isSubmitted) {
            return _buildSuccessState(context);
          }
          return _buildForm(context);
        },
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                size: 60,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Inquiry Sent!',
              style: AppTextStyles.h3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              _store.successMessage ??
                  'Your inquiry has been submitted successfully.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomButton(
              label: 'Back to Home',
              onPressed: () {
                _store.clearMessages();
                context.go('/');
              },
              prefixIcon: Icons.home_outlined,
            ),
            const SizedBox(height: 12),
            CustomButton(
              label: 'Send Another Inquiry',
              onPressed: () => _store.clearMessages(),
              variant: ButtonVariant.outline,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            _buildHeaderCard(),
            const SizedBox(height: 16),
            // Form card
            _buildFormCard(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.mail_rounded, color: Colors.white, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Let\'s Work Together',
                  style: AppTextStyles.h5.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tell us about your project and we\'ll get back to you within 24 hours.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact Information', style: AppTextStyles.h5),
          const SizedBox(height: 20),
          // Name
          Observer(
            builder: (_) => TextFormField(
              decoration: InputDecoration(
                labelText: 'Full Name *',
                hintText: 'Enter your full name',
                prefixIcon:
                    const Icon(Icons.person_outline_rounded, size: 20),
                errorText: _store.clientNameError,
              ),
              onChanged: _store.setClientName,
              textInputAction: TextInputAction.next,
            ),
          ),
          const SizedBox(height: 16),
          // Email
          Observer(
            builder: (_) => TextFormField(
              decoration: InputDecoration(
                labelText: 'Email Address *',
                hintText: 'your@email.com',
                prefixIcon: const Icon(Icons.mail_outline_rounded, size: 20),
                errorText: _store.emailError,
              ),
              onChanged: _store.setEmail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
          ),
          const SizedBox(height: 16),
          // Phone
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Phone Number (Optional)',
              hintText: '+1 (555) 000-0000',
              prefixIcon: Icon(Icons.phone_outlined, size: 20),
            ),
            onChanged: _store.setPhoneNumber,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 24),
          Text('Project Details', style: AppTextStyles.h5),
          const SizedBox(height: 16),
          // Project Type
          Observer(
            builder: (_) => DropdownButtonFormField<String>(
              value:
                  _store.projectType.isEmpty ? null : _store.projectType,
              decoration: InputDecoration(
                labelText: 'Project Type *',
                prefixIcon:
                    const Icon(Icons.video_camera_front_outlined, size: 20),
                errorText: _store.projectTypeError,
              ),
              items: AppConstants.projectTypes
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (val) => _store.setProjectType(val ?? ''),
            ),
          ),
          const SizedBox(height: 16),
          // Message
          Observer(
            builder: (_) => TextFormField(
              decoration: InputDecoration(
                labelText: 'Message / Requirements *',
                hintText:
                    'Describe your project, goals, and any specific requirements...',
                prefixIcon:
                    const Icon(Icons.message_outlined, size: 20),
                errorText: _store.messageError,
                alignLabelWithHint: true,
              ),
              onChanged: _store.setMessage,
              maxLines: 4,
              textInputAction: TextInputAction.newline,
              initialValue: _store.message,
            ),
          ),
          const SizedBox(height: 16),
          // Budget Range
          Observer(
            builder: (_) => DropdownButtonFormField<String>(
              value: _store.budgetRange,
              decoration: const InputDecoration(
                labelText: 'Budget Range (Optional)',
                prefixIcon:
                    Icon(Icons.attach_money_rounded, size: 20),
              ),
              items: AppConstants.budgetRanges
                  .map((range) => DropdownMenuItem(
                        value: range,
                        child: Text(range),
                      ))
                  .toList(),
              onChanged: _store.setBudgetRange,
            ),
          ),
          const SizedBox(height: 16),
          // Timeline
          Observer(
            builder: (_) => DropdownButtonFormField<String>(
              value: _store.timeline,
              decoration: const InputDecoration(
                labelText: 'Timeline Preference (Optional)',
                prefixIcon: Icon(Icons.calendar_today_outlined, size: 20),
              ),
              items: AppConstants.timelineOptions
                  .map((option) => DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      ))
                  .toList(),
              onChanged: _store.setTimeline,
            ),
          ),
          const SizedBox(height: 24),
          // Error message
          Observer(
            builder: (_) => _store.error != null
                ? Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.error.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline,
                            color: AppColors.error, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _store.error!,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          // Submit button
          Observer(
            builder: (_) => CustomButton(
              label: 'Submit Inquiry',
              isLoading: _store.isSubmitting,
              onPressed: () => _store.submitInquiry(),
              prefixIcon: Icons.send_rounded,
            ),
          ),
          const SizedBox(height: 12),
          // Privacy note
          Text(
            'By submitting this form, you agree to be contacted by our team regarding your inquiry.',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textLight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
