import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../data/models/video_post_model.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';

class VideoPostCard extends StatelessWidget {
  final VideoPost post;
  final VoidCallback onLike;
  final VoidCallback onTap;

  const VideoPostCard({
    Key? key,
    required this.post,
    required this.onLike,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThumbnail(),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: post.thumbnailUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            placeholder: (context, url) => Container(
              color: AppColors.lightGrayColor,
              child: const Center(
                child: Icon(
                  Icons.video_library,
                  size: 48,
                  color: AppColors.darkGrayColor,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.lightGrayColor,
              child: const Center(
                child: Icon(
                  Icons.broken_image,
                  size: 48,
                  color: AppColors.darkGrayColor,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                post.videoType.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: Icon(
                Icons.play_circle_outline,
                size: 64,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title,
            style: AppTextStyles.subheadline,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          if (post.clientName != null)
            Text(
              'Client: ${post.clientName}',
              style: AppTextStyles.caption,
            ),
          const SizedBox(height: 8),
          Text(
            post.description,
            style: AppTextStyles.body,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          if (post.hashtags.isNotEmpty)
            Wrap(
              spacing: 4,
              children: post.hashtags
                  .take(3)
                  .map(
                    (tag) => Chip(
                      label: Text(
                        '#$tag',
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  )
                  .toList(),
            ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.visibility_outlined,
                    size: 16,
                    color: AppColors.darkGrayColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${post.views}',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: onLike,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: AppColors.primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${post.likes}',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
