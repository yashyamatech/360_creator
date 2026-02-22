import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../store/video_detail_store.dart';
import '../../../../data/models/video_post_model.dart';
import '../../../../data/repositories/video_repository.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/app_error_widget.dart';

class VideoDetailScreen extends StatefulWidget {
  final String videoId;
  final VideoPost? initialPost;

  const VideoDetailScreen({
    super.key,
    required this.videoId,
    this.initialPost,
  });

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  late final VideoDetailStore _store;

  @override
  void initState() {
    super.initState();
    _store = VideoDetailStore(VideoRepository());
    if (widget.initialPost != null) {
      _store.setPost(widget.initialPost!);
      _store.incrementViews();
    } else {
      _store.fetchPost(widget.videoId);
    }
  }

  @override
  void dispose() {
    _store.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      body: Observer(
        builder: (_) {
          if (_store.isLoading) {
            return const LoadingWidget(message: 'Loading video...');
          }

          if (_store.hasError && !_store.hasPost) {
            return AppErrorWidget(
              message: _store.error ?? 'Failed to load video.',
              onRetry: () => _store.fetchPost(widget.videoId),
            );
          }

          if (!_store.hasPost) {
            return const AppErrorWidget(message: 'Video not found.');
          }

          return _buildContent(context, _store.currentPost!);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, VideoPost post) {
    return CustomScrollView(
      slivers: [
        // Video Player / Thumbnail
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.width * 9 / 16,
          pinned: true,
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_rounded,
                  color: Colors.white, size: 16),
            ),
            onPressed: () => context.pop(),
          ),
          actions: [
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.share_outlined,
                    color: Colors.white, size: 20),
              ),
              onPressed: () => _sharePost(context, post),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: _buildVideoPlayer(post),
          ),
        ),
        // Content
        SliverToBoxAdapter(
          child: _buildPostDetails(context, post),
        ),
      ],
    );
  }

  Widget _buildVideoPlayer(VideoPost post) {
    return Stack(
      children: [
        // Thumbnail / Video placeholder
        SizedBox.expand(
          child: post.thumbnailUrl != null
              ? CachedNetworkImage(
                  imageUrl: post.thumbnailUrl!,
                  fit: BoxFit.cover,
                )
              : Container(
                  color: Colors.black,
                  child: const Center(
                    child: Icon(
                      Icons.video_library_outlined,
                      size: 64,
                      color: Colors.white30,
                    ),
                  ),
                ),
        ),
        // Play overlay
        Positioned.fill(
          child: GestureDetector(
            onTap: () => _store.togglePlayPause(),
            child: Observer(
              builder: (_) => Container(
                color: Colors.transparent,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: _store.isPlaying ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        size: 48,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Note: In production, replace with actual video_player widget
        // VideoPlayer integration would go here
      ],
    );
  }

  Widget _buildPostDetails(BuildContext context, VideoPost post) {
    return Container(
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main info
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Type badge + date
                Row(
                  children: [
                    _buildTypeBadge(post.videoTypeLabel),
                    const Spacer(),
                    Text(
                      _formatDate(post.createdAt),
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Title
                Text(post.title, style: AppTextStyles.h4),
                const SizedBox(height: 8),
                // Client
                if (post.clientName != null)
                  Row(
                    children: [
                      const Icon(
                        Icons.business_rounded,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        post.clientName!,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                // Engagement row
                Row(
                  children: [
                    Observer(
                      builder: (_) => _buildEngagementButton(
                        icon: _store.currentPost?.isLiked ?? false
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        label: (_store.currentPost ?? post).formattedLikes,
                        color: (_store.currentPost?.isLiked ?? false)
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        onTap: () => _store.toggleLike(),
                      ),
                    ),
                    const SizedBox(width: 20),
                    _buildEngagementButton(
                      icon: Icons.remove_red_eye_outlined,
                      label: post.formattedViews,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 20),
                    if (post.projectDuration != null)
                      _buildEngagementButton(
                        icon: Icons.schedule_outlined,
                        label: post.projectDuration!,
                        color: AppColors.textSecondary,
                      ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Description
          if (post.description != null)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About This Project', style: AppTextStyles.h5),
                  const SizedBox(height: 12),
                  Text(
                    post.description!,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          const Divider(height: 1),
          // Project details
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Project Details', style: AppTextStyles.h5),
                const SizedBox(height: 16),
                if (post.actorNames.isNotEmpty) ...[
                  _buildDetailRow(
                    'Cast',
                    post.actorNames.join(', '),
                    Icons.people_outline_rounded,
                  ),
                  const SizedBox(height: 12),
                ],
                if (post.budgetRange != null) ...[
                  _buildDetailRow(
                    'Budget Range',
                    post.budgetRange!,
                    Icons.attach_money_rounded,
                  ),
                  const SizedBox(height: 12),
                ],
                if (post.projectDuration != null)
                  _buildDetailRow(
                    'Duration',
                    post.projectDuration!,
                    Icons.timer_outlined,
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Hashtags
          if (post.hashtags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: post.hashtags
                    .map((tag) => _buildHashtagChip(tag))
                    .toList(),
              ),
            ),
          // CTA Buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            child: Column(
              children: [
                CustomButton(
                  label: 'Book a Similar Project',
                  onPressed: () => context.push('/booking', extra: post),
                  prefixIcon: Icons.calendar_month_rounded,
                ),
                const SizedBox(height: 12),
                CustomButton(
                  label: 'Send Inquiry',
                  onPressed: () => context.push('/inquiry', extra: {
                    'videoId': post.id,
                    'videoTitle': post.title,
                  }),
                  variant: ButtonVariant.outline,
                  prefixIcon: Icons.mail_outline_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTextStyles.label.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEngagementButton({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.label),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHashtagChip(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(tag, style: AppTextStyles.hashtag),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  void _sharePost(BuildContext context, VideoPost post) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing: ${post.title}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
