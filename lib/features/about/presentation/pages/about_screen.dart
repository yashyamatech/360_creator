import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/widgets/custom_button.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'About Us',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeroSection(),
            _buildAboutSection(context),
            _buildServicesSection(context),
            _buildStatsSection(),
            _buildContactSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.videocam, size: 64, color: Colors.white),
            SizedBox(height: 12),
            Text(
              '360 Creator',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Your Vision, Our Creation',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Who We Are', style: AppTextStyles.headline),
          const SizedBox(height: 12),
          const Text(
            '360 Creator is a full-service video production agency specializing in '
            'high-quality video creation and editing. We bring stories to life through '
            'compelling visual content that resonates with audiences and drives results.',
            style: AppTextStyles.body,
          ),
          const SizedBox(height: 12),
          const Text(
            'From concept to final cut, our team of experienced videographers, editors, '
            'and creative directors work together to deliver exceptional video content '
            'tailored to your brand and goals.',
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    // Note: Icons.movie_edit_outlined does not exist in Flutter — use Icons.movie_edit
    final services = [
      {
        'icon': Icons.videocam_outlined,
        'title': 'Video Creation',
        'description': 'Full production from concept to screen',
      },
      {
        'icon': Icons.movie_edit,        // ← was movie_edit_outlined (invalid)
        'title': 'Video Editing',
        'description': 'Professional post-production services',
      },
      {
        'icon': Icons.auto_awesome,
        'title': 'Motion Graphics',
        'description': 'Engaging animations and visual effects',
      },
      {
        'icon': Icons.color_lens_outlined,
        'title': 'Color Grading',
        'description': 'Professional color correction and grading',
      },
    ];

    return Container(
      color: AppColors.lightGrayColor,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Our Services', style: AppTextStyles.headline),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        service['icon'] as IconData,
                        color: AppColors.primaryColor,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        service['title'] as String,
                        style:
                            const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service['description'] as String,
                        style: AppTextStyles.caption,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    final stats = [
      {'value': '200+', 'label': 'Projects'},
      {'value': '50+', 'label': 'Clients'},
      {'value': '5+', 'label': 'Years'},
      {'value': '15+', 'label': 'Awards'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: stats
            .map(
              (stat) => Column(
                children: [
                  Text(
                    stat['value']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    stat['label']!,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Get in Touch', style: AppTextStyles.headline),
          const SizedBox(height: 12),
          const Text(
            "Ready to start your project? We'd love to hear from you.",
            style: TextStyle(color: AppColors.darkGrayColor),
          ),
          const SizedBox(height: 24),
          CustomButton(
            label: 'Make an Inquiry',
            onPressed: () => context.push('/inquiry'),
            icon: Icons.mail_outline,
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.video_library_outlined),
            label: const Text('View Our Work'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              side: const BorderSide(color: AppColors.primaryColor),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
