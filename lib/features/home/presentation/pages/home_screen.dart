import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import '../../store/home_store.dart';
import '../../../../data/repositories/video_repository.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../widgets/video_post_card.dart';
import '../widgets/inquiry_fab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeStore _store;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _store = HomeStore(VideoRepository());
    _store.initialize();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_store.isLoading && _store.hasMorePosts) {
        _store.fetchVideoPosts();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: LogoAppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
            tooltip: 'Search',
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
            tooltip: 'Notifications',
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (_store.isLoading && _store.videoPosts.isEmpty) {
            return const ShimmerGrid();
          }

          if (_store.hasError && _store.videoPosts.isEmpty) {
            return AppErrorWidget(
              message: _store.error ?? 'Failed to load posts.',
              onRetry: () => _store.fetchVideoPosts(refresh: true),
            );
          }

          if (_store.isEmpty) {
            return EmptyStateWidget(
              title: 'No Videos Yet',
              message:
                  'Our portfolio is coming soon! Send us an inquiry to get started.',
              icon: Icons.videocam_outlined,
              actionLabel: 'Send Inquiry',
              onAction: () => context.push('/inquiry'),
            );
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () => _store.fetchVideoPosts(refresh: true),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Hero/Banner section
                SliverToBoxAdapter(
                  child: _buildHeroBanner(context),
                ),
                // Posts list
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < _store.videoPosts.length) {
                        final post = _store.videoPosts[index];
                        return VideoPostCard(
                          post: post,
                          onTap: () {
                            context.push('/video/${post.id}', extra: post);
                          },
                          onLike: () => _store.toggleLike(post.id),
                          onInquiry: () => context.push(
                            '/inquiry',
                            extra: {'videoId': post.id, 'videoTitle': post.title},
                          ),
                        );
                      } else if (_store.isLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      } else if (!_store.hasMorePosts) {
                        return _buildEndOfFeedMessage();
                      }
                      return null;
                    },
                    childCount: _store.videoPosts.length +
                        (_store.isLoading || !_store.hasMorePosts ? 1 : 0),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: InquiryBottomBar(
        onInquiry: () => context.push('/inquiry'),
        onAbout: () => context.push('/about'),
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Story,\nOur Vision',
            style: AppTextStyles.h3.copyWith(
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Professional video content that elevates your brand.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white.withOpacity(0.85),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatBadge('50+', 'Projects'),
              const SizedBox(width: 16),
              _buildStatBadge('100K+', 'Views'),
              const SizedBox(width: 16),
              _buildStatBadge('98%', 'Happy Clients'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBadge(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.h5.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildEndOfFeedMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          const Divider(),
          const SizedBox(height: 16),
          Text(
            "You've seen it all!",
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Interested in our work? Send us an inquiry.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
