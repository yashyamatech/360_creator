import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../data/models/video_post_model.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';

class VideoPostCard extends StatelessWidget {
  final VideoPost post;
  final VoidCallback onTap;
  final VoidCallback onLike;
  final VoidCallback onInquiry;

  const VideoPostCard({
    super.key,
    required this.post,
    required this.onTap,
    required this.onLike,
    required this.onInquiry,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppColors.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThumbnail(context),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: post.thumbnailUrl != null
                ? CachedNetworkImage(
                    imageUrl: post.thumbnailUrl!,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: AppColors.backgroundSecondary,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                    errorWidget: (_, __, ___) => _buildPlaceholder(),
                  )
                : _buildPlaceholder(),
          ),
        ),
        // Dark gradient overlay
        Positioned.fill(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppColors.darkOverlayGradient,
              ),
            ),
          ),
        ),
        // Play button overlay
        const Positioned.fill(
          child: Center(
            child: _PlayButtonOverlay(),
          ),
        ),
        // Video type badge
        Positioned(
          top: 12,
          left: 12,
          child: _buildVideoTypeBadge(),
        ),
        // Engagement stats at bottom of thumbnail
        Positioned(
          bottom: 12,
          right: 12,
          child: _buildEngagementStats(),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.backgroundSecondary,
      child: const Center(
        child: Icon(
          Icons.video_library_outlined,
          size: 48,
          color: AppColors.textLight,
        ),
      ),
    );
  }

  Widget _buildVideoTypeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        post.videoTypeLabel,
        style: AppTextStyles.caption.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEngagementStats() {
    return Row(
      children: [
        _buildStatChip(Icons.remove_red_eye_outlined, post.formattedViews),
        const SizedBox(width: 8),
        _buildStatChip(Icons.favorite_border_rounded, post.formattedLikes),
      ],
    );
  }

  Widget _buildStatChip(IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            value,
            style: AppTextStyles.caption.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            post.title,
            style: AppTextStyles.h5,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          // Client name & duration
          if (post.clientName != null)
            Row(
              children: [
                const Icon(
                  Icons.business_outlined,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    post.clientName!,
                    style: AppTextStyles.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (post.projectDuration != null) ...[
                  const Icon(
                    Icons.schedule_outlined,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    post.projectDuration!,
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ],
            ),
          const SizedBox(height: 10),
          // Description
          if (post.description != null)
            Text(
              post.description!,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          const SizedBox(height: 12),
          // Hashtags
          if (post.hashtags.isNotEmpty)
            SizedBox(
              height: 28,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: post.hashtags.take(4).length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: _buildHashtagChip(post.hashtags[i]),
                ),
              ),
            ),
          const SizedBox(height: 12),
          // Actions row
          Row(
            children: [
              // Like button
              _buildActionButton(
                icon: post.isLiked
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                label: post.formattedLikes,
                color: post.isLiked ? AppColors.primary : AppColors.textSecondary,
                onTap: onLike,
              ),
              const SizedBox(width: 16),
              // Views
              _buildActionButton(
                icon: Icons.remove_red_eye_outlined,
                label: post.formattedViews,
                color: AppColors.textSecondary,
                onTap: null,
              ),
              const Spacer(),
              // Inquiry button
              GestureDetector(
                onTap: onInquiry,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.mail_outline_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Inquire',
                        style: AppTextStyles.buttonSmall.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHashtagChip(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        tag,
        style: AppTextStyles.hashtag,
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButtonOverlay extends StatelessWidget {
  const _PlayButtonOverlay();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: const Icon(
        Icons.play_arrow_rounded,
        size: 36,
        color: AppColors.primary,
      ),
    );
  }
}
