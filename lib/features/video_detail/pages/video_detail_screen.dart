import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../data/models/video_post_model.dart';
import '../../../data/repositories/video_repository.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../home/store/home_store.dart';

class VideoDetailScreen extends StatefulWidget {
  final String videoId;

  const VideoDetailScreen({Key? key, required this.videoId}) : super(key: key);

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  VideoPost? _videoPost;
  bool _isLoading = true;
  String? _error;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  Future<void> _loadVideo() async {
    try {
      final repository = context.read<VideoRepository>();
      final post = await repository.getVideoPostById(widget.videoId);
      if (mounted) {
        setState(() {
          _videoPost = post;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _handleLike() {
    if (_videoPost == null) return;
    final homeStore = context.read<HomeStore>();
    homeStore.likePost(_videoPost!.id);
    setState(() {
      _isLiked = !_isLiked;
      _videoPost = _videoPost!.copyWith(
        likes: _isLiked ? _videoPost!.likes + 1 : _videoPost!.likes - 1,
      );
    });
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
        title: Text(
          _videoPost?.title ?? 'Video Detail',
          style: const TextStyle(
            color: AppColors.textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          if (_videoPost != null)
            IconButton(
              icon: Icon(
                _isLiked ? Icons.favorite : Icons.favorite_border,
                color: AppColors.primaryColor,
              ),
              onPressed: _handleLike,
              tooltip: 'Like',
            ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: _videoPost != null
          ? _buildBookingBar(context)
          : null,
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: LoadingWidget());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.errorColor,
              ),
              const SizedBox(height: 16),
              const Text('Failed to load video'),
              const SizedBox(height: 8),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.darkGrayColor),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _loadVideo,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_videoPost == null) {
      return const Center(child: Text('Video not found'));
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVideoPlayer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMetadata(),
                const SizedBox(height: 16),
                _buildDescription(),
                const SizedBox(height: 16),
                if (_videoPost!.actorNames.isNotEmpty) _buildActors(),
                if (_videoPost!.hashtags.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildHashtags(),
                ],
                const SizedBox(height: 80), // Space for bottom bar
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: _videoPost!.thumbnailUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            placeholder: (context, url) => Container(
              color: AppColors.lightGrayColor,
              child: const Center(child: LoadingWidget()),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.black,
              child: const Center(
                child: Icon(Icons.broken_image, color: Colors.white, size: 48),
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
                  // Video playback would be implemented here
                  // using video_player package or launching URL
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadata() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_videoPost!.title, style: AppTextStyles.headline),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.3),
                ),
              ),
              child: Text(
                _videoPost!.videoType.toUpperCase(),
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
                Text('${_videoPost!.views}', style: AppTextStyles.caption),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: _handleLike,
                  child: Row(
                    children: [
                      Icon(
                        _isLiked ? Icons.favorite : Icons.favorite_border,
                        size: 16,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${_videoPost!.likes}',
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
        if (_videoPost!.clientName != null) ...[
          const SizedBox(height: 8),
          Text('Client: ${_videoPost!.clientName}', style: AppTextStyles.caption),
        ],
        if (_videoPost!.projectDuration != null) ...[
          const SizedBox(height: 4),
          Text(
            'Duration: ${_videoPost!.projectDuration}',
            style: AppTextStyles.caption,
          ),
        ],
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About this project',
          style: AppTextStyles.subheadline,
        ),
        const SizedBox(height: 8),
        Text(_videoPost!.description, style: AppTextStyles.body),
      ],
    );
  }

  Widget _buildActors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Cast', style: AppTextStyles.subheadline),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: _videoPost!.actorNames
              .map(
                (actor) => Chip(
                  avatar: CircleAvatar(
                    backgroundColor: AppColors.secondaryColor,
                    child: Text(
                      actor[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
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

  Widget _buildHashtags() {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: _videoPost!.hashtags
          .map(
            (tag) => GestureDetector(
              onTap: () {},
              child: Text(
                '#$tag',
                style: const TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
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
        onPressed: () => context.push('/booking/${_videoPost!.id}'),
        icon: Icons.calendar_month,
      ),
    );
  }
}
