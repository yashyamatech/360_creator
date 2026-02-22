import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../store/booking_store.dart';
import '../../../../data/models/video_post_model.dart';
import '../../../../data/repositories/booking_repository.dart';
import '../../../../config/app_constants.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_app_bar.dart';

class BookingScreen extends StatefulWidget {
  final VideoPost? referenceVideo;

  const BookingScreen({super.key, this.referenceVideo});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late final BookingStore _store;

  @override
  void initState() {
    super.initState();
    _store = BookingStore(BookingRepository());
    if (widget.referenceVideo != null) {
      _store.setReferenceVideo(widget.referenceVideo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: const CustomAppBar(
        title: 'Book a Project',
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
                Icons.calendar_month_rounded,
                size: 55,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Booking Submitted!',
              style: AppTextStyles.h3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              _store.successMessage ??
                  'Your booking has been submitted. We\'ll confirm soon.',
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
              label: 'Browse More Videos',
              onPressed: () {
                _store.clearMessages();
                context.go('/');
              },
              variant: ButtonVariant.outline,
              prefixIcon: Icons.video_library_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reference video card (if applicable)
          if (widget.referenceVideo != null)
            _buildReferenceVideoCard(widget.referenceVideo!),
          const SizedBox(height: 16),
          // Form card
          _buildFormCard(context),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildReferenceVideoCard(VideoPost video) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.bookmark_rounded,
                color: AppColors.primary,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Reference Project',
                style: AppTextStyles.label.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Thumbnail
              if (video.thumbnailUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: video.thumbnailUrl!,
                    width: 80,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (video.clientName != null)
                      Text(
                        video.clientName!,
                        style: AppTextStyles.bodySmall,
                      ),
                    Text(
                      video.videoTypeLabel,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
          Text('Your Information', style: AppTextStyles.h5),
          const SizedBox(height: 20),
          // Name
          Observer(
            builder: (_) => TextFormField(
              decoration: InputDecoration(
                labelText: 'Full Name *',
                hintText: 'Enter your full name',
                prefixIcon: const Icon(Icons.person_outline_rounded, size: 20),
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
          Text('Project Requirements', style: AppTextStyles.h5),
          const SizedBox(height: 16),
          // Requirements
          Observer(
            builder: (_) => TextFormField(
              decoration: InputDecoration(
                labelText: 'Project Requirements *',
                hintText:
                    'Describe what you need: script, actors, locations, style, deliverables...',
                prefixIcon:
                    const Icon(Icons.description_outlined, size: 20),
                errorText: _store.requirementsError,
                alignLabelWithHint: true,
              ),
              onChanged: _store.setProjectRequirements,
              maxLines: 5,
              textInputAction: TextInputAction.newline,
            ),
          ),
          const SizedBox(height: 16),
          // Budget
          Observer(
            builder: (_) => DropdownButtonFormField<String>(
              value: _store.budget,
              decoration: const InputDecoration(
                labelText: 'Budget (Optional)',
                prefixIcon: Icon(Icons.attach_money_rounded, size: 20),
              ),
              items: AppConstants.budgetRanges
                  .map((range) => DropdownMenuItem(
                        value: range,
                        child: Text(range),
                      ))
                  .toList(),
              onChanged: _store.setBudget,
            ),
          ),
          const SizedBox(height: 16),
          // Timeline
          Observer(
            builder: (_) => DropdownButtonFormField<String>(
              value: _store.timeline,
              decoration: const InputDecoration(
                labelText: 'Preferred Timeline (Optional)',
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
                      border: Border.all(
                          color: AppColors.error.withOpacity(0.3)),
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
          // Submit
          Observer(
            builder: (_) => CustomButton(
              label: 'Submit Booking',
              isLoading: _store.isSubmitting,
              onPressed: () => _store.submitBooking(),
              prefixIcon: Icons.calendar_month_rounded,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Our team will review your booking and send a confirmation within 24 hours.',
            style: AppTextStyles.caption.copyWith(color: AppColors.textLight),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
