import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../store/about_store.dart';
import '../../../../data/models/agency_info_model.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/loading_widget.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late final AboutStore _store;

  @override
  void initState() {
    super.initState();
    _store = AboutStore();
    _store.fetchAgencyInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: CustomAppBar(
        title: 'About Us',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.mail_outline_rounded),
            onPressed: () => context.push('/inquiry'),
            tooltip: 'Inquire',
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (_store.isLoading) {
            return const LoadingWidget(message: 'Loading...');
          }

          if (!_store.hasInfo) {
            return const LoadingWidget();
          }

          final info = _store.agencyInfo!;
          return _buildContent(context, info);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, AgencyInfo info) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero section
          _buildHeroSection(info),
          const SizedBox(height: 16),
          // Mission & Vision
          _buildMissionVision(info),
          const SizedBox(height: 16),
          // Services
          _buildServices(context),
          const SizedBox(height: 16),
          // Team
          if (info.teamMembers.isNotEmpty)
            _buildTeamSection(info),
          const SizedBox(height: 16),
          // Testimonials
          if (info.testimonials.isNotEmpty)
            _buildTestimonials(info),
          const SizedBox(height: 16),
          // Contact
          _buildContactSection(context, info),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeroSection(AgencyInfo info) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
          child: Column(
            children: [
              // Logo
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.videocam_rounded,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                info.companyName,
                style: AppTextStyles.h2.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              if (info.description != null)
                Text(
                  info.description!,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 20),
              // Social links
              _buildSocialLinks(info),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLinks(AgencyInfo info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (info.instagramUrl != null)
          _buildSocialButton(
            icon: Icons.camera_alt_outlined,
            color: AppColors.instagram,
            url: info.instagramUrl!,
          ),
        if (info.facebookUrl != null)
          _buildSocialButton(
            icon: Icons.facebook,
            color: AppColors.facebook,
            url: info.facebookUrl!,
          ),
        if (info.youtubeUrl != null)
          _buildSocialButton(
            icon: Icons.play_circle_outline_rounded,
            color: AppColors.youtube,
            url: info.youtubeUrl!,
          ),
        if (info.linkedinUrl != null)
          _buildSocialButton(
            icon: Icons.business_center_outlined,
            color: AppColors.linkedin,
            url: info.linkedinUrl!,
          ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required String url,
  }) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
            ),
          ],
        ),
        child: Icon(icon, size: 22, color: color),
      ),
    );
  }

  Widget _buildMissionVision(AgencyInfo info) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (info.missionStatement != null)
            Expanded(
              child: _buildInfoCard(
                title: 'Our Mission',
                content: info.missionStatement!,
                icon: Icons.rocket_launch_outlined,
                color: AppColors.primary,
              ),
            ),
          if (info.missionStatement != null && info.visionStatement != null)
            const SizedBox(width: 12),
          if (info.visionStatement != null)
            Expanded(
              child: _buildInfoCard(
                title: 'Our Vision',
                content: info.visionStatement!,
                icon: Icons.visibility_outlined,
                color: AppColors.secondary,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    required IconData icon,
    required Color color,
  }) {
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
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(title, style: AppTextStyles.h5),
          const SizedBox(height: 8),
          Text(
            content,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServices(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppColors.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Our Services', style: AppTextStyles.h4),
            const SizedBox(height: 16),
            _buildServiceItem(
              icon: Icons.videocam_rounded,
              title: 'Video Creation',
              description:
                  'Full-scale video production with professional actors, cinematography, and storytelling.',
              color: AppColors.primary,
            ),
            const SizedBox(height: 16),
            _buildServiceItem(
              icon: Icons.movie_edit_outlined,
              title: 'Video Editing',
              description:
                  'Expert post-production editing, color grading, sound design, and visual effects.',
              color: AppColors.secondary,
            ),
            const SizedBox(height: 16),
            _buildServiceItem(
              icon: Icons.share_rounded,
              title: 'Social Media Strategy',
              description:
                  'Content strategy, scheduling, and optimization for maximum social media impact.',
              color: AppColors.accent,
            ),
            const SizedBox(height: 16),
            _buildServiceItem(
              icon: Icons.analytics_outlined,
              title: 'Brand Consulting',
              description:
                  'Creative direction and brand identity guidance to make your content stand out.',
              color: AppColors.primaryDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.h5),
              const SizedBox(height: 4),
              Text(
                description,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTeamSection(AgencyInfo info) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppColors.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Meet The Team', style: AppTextStyles.h4),
            const SizedBox(height: 16),
            ...info.teamMembers.map((member) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildTeamMemberCard(member),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMemberCard(TeamMember member) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              member.name.split(' ').map((n) => n[0]).take(2).join(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(member.name, style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              )),
              Text(
                member.role,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (member.bio != null)
                Text(
                  member.bio!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTestimonials(AgencyInfo info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('What Clients Say', style: AppTextStyles.h4),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: info.testimonials.length,
            itemBuilder: (_, index) => _buildTestimonialCard(
              info.testimonials[index],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTestimonialCard(Testimonial testimonial) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stars
          Row(
            children: List.generate(5, (i) {
              final rating = testimonial.rating ?? 5;
              return Icon(
                i < rating.floor()
                    ? Icons.star_rounded
                    : (i < rating ? Icons.star_half_rounded : Icons.star_outline_rounded),
                size: 16,
                color: AppColors.accent,
              );
            }),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Text(
              '"${testimonial.message}"',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
              overflow: TextOverflow.fade,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            testimonial.clientName,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          if (testimonial.company != null)
            Text(testimonial.company!, style: AppTextStyles.caption),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context, AgencyInfo info) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppColors.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Get In Touch', style: AppTextStyles.h4),
            const SizedBox(height: 16),
            if (info.email != null)
              _buildContactRow(
                icon: Icons.mail_outline_rounded,
                value: info.email!,
                onTap: () => _launchUrl('mailto:${info.email}'),
              ),
            if (info.phoneNumber != null)
              _buildContactRow(
                icon: Icons.phone_outlined,
                value: info.phoneNumber!,
                onTap: () => _launchUrl('tel:${info.phoneNumber}'),
              ),
            if (info.address != null)
              _buildContactRow(
                icon: Icons.location_on_outlined,
                value: info.address!,
              ),
            if (info.website != null)
              _buildContactRow(
                icon: Icons.language_outlined,
                value: info.website!,
                onTap: () => _launchUrl(info.website!),
              ),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Send Us an Inquiry',
              onPressed: () => context.push('/inquiry'),
              prefixIcon: Icons.mail_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String value,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: onTap != null ? AppColors.primary : AppColors.textPrimary,
                  decoration: onTap != null ? TextDecoration.underline : null,
                ),
              ),
            ),
            if (onTap != null)
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: AppColors.textLight,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
