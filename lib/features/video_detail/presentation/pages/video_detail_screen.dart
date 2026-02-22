import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../data/repositories/video_repository.dart';
import '../../../../config/service_locator.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../store/video_detail_store.dart';

class VideoDetailScreen extends StatefulWidget {
  final String videoId;

  const VideoDetailScreen({Key? key, required this.videoId}) : super(key: key);

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  late final VideoDetailStore _store;

  @override
  void initState() {
    super.initState();
    _store = VideoDetailStore(locator<VideoRepository>());
    _store.fetchVideo(widget.videoId);
  }

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
        title: Observer(
          builder: (_) => Text(
            _store.videoPost?.title ?? 'Video Detail',
            style: const TextStyle(
              color: AppColors.textColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        actions: [
          Observer(
            builder: (_) => _store.hasPost
                ? IconButton(
                    icon: Icon(
                      _store.isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: _store.toggleLike,
                    tooltip: 'Like',
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: Observer(
        builder: (_) => _store.hasPost
            ? _buildBookingBar(context)
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildBody() {
    return Observer(builder: (_) {
      if (_store.isLoading) {
        return const Center(child: LoadingWidget());
      }

      // line 59 in user's file — hasError and hasPost are now computed getters
      if (_store.hasError && !_store.hasPost) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline,
                    size: 64, color: AppColors.errorColor),
                const SizedBox(height: 16),
                const Text('Failed to load video'),
                const SizedBox(height: 8),
                Text(
                  _store.error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.darkGrayColor),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => _store.fetchVideo(widget.videoId),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      }

      if (!_store.hasPost) {
        return const Center(child: Text('Video not found'));
      }

      final post = _store.videoPost!;

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVideoPlayer(post.thumbnailUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMetadata(post),
                  const SizedBox(height: 16),
                  _buildDescription(post.description),
                  const SizedBox(height: 16),
                  if (post.actorNames.isNotEmpty) _buildActors(post.actorNames),
                  if (post.hashtags.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildHashtags(post.hashtags),
                  ],
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildVideoPlayer(String thumbnailUrl) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: thumbnailUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            placeholder: (context, url) => Container(
              color: AppColors.lightGrayColor,
              child: const Center(child: LoadingWidget()),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.black,
              child: const Center(
                child:
                    Icon(Icons.broken_image, color: Colors.white, size: 48),
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                iconSize: 64,
                icon: const Icon(Icons.play_arrow, color: Colors.white),
                onPressed: () {
                  // Video playback — implement with video_player / chewie
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadata(post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(post.title, style: AppTextStyles.headline),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: AppColors.primaryColor.withOpacity(0.3)),
              ),
              child: Text(
                post.videoType.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.visibility_outlined,
                    size: 16, color: AppColors.darkGrayColor),
                const SizedBox(width: 4),
                Text('${post.views}', style: AppTextStyles.caption),
                const SizedBox(width: 16),
                Observer(
                  builder: (_) => GestureDetector(
                    onTap: _store.toggleLike,
                    child: Row(
                      children: [
                        Icon(
                          _store.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 16,
                          color: AppColors.primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${_store.videoPost?.likes ?? post.likes}',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primaryColor,
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
        if (post.clientName != null) ...[
          const SizedBox(height: 8),
          Text('Client: ${post.clientName}', style: AppTextStyles.caption),
        ],
        if (post.projectDuration != null) ...[
          const SizedBox(height: 4),
          Text('Duration: ${post.projectDuration}',
              style: AppTextStyles.caption),
        ],
      ],
    );
  }

  Widget _buildDescription(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('About this project', style: AppTextStyles.subheadline),
        const SizedBox(height: 8),
        Text(description, style: AppTextStyles.body),
      ],
    );
  }

  Widget _buildActors(List<String> actors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Cast', style: AppTextStyles.subheadline),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: actors
              .map(
                (actor) => Chip(
                  avatar: CircleAvatar(
                    backgroundColor: AppColors.secondaryColor,
                    child: Text(
                      actor[0].toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white, fontSize: 12),
                    ),
                  ),
                  label: Text(actor),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildHashtags(List<String> hashtags) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: hashtags
          .map(
            (tag) => Text(
              '#$tag',
              style: const TextStyle(
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildBookingBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: CustomButton(
        label: 'Book This Style',
        onPressed: () =>
            context.push('/booking/${_store.videoPost!.id}'),
        icon: Icons.calendar_month,
      ),
    );
  }
}
