import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/utils/responsive_helper.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/shimmer_loading.dart';
import '../../../shared/theme/app_colors.dart';
import '../store/home_store.dart';
import '../widgets/video_post_card.dart';
import '../widgets/inquiry_fab.dart';
import '../widgets/about_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  late HomeStore _homeStore;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _homeStore = context.read<HomeStore>();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      if (_homeStore.hasMorePosts && !_homeStore.isLoading) {
        _homeStore.fetchVideoPosts();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          '360 Creator',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textColor),
            onPressed: () => context.push('/search'),
            tooltip: 'Search videos',
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (_homeStore.isLoading && _homeStore.videoPosts.isEmpty) {
            return _buildShimmerList(isMobile);
          }

          if (_homeStore.error != null && _homeStore.videoPosts.isEmpty) {
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
                    Text(
                      'Failed to load videos',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _homeStore.error!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.darkGrayColor),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => _homeStore.fetchVideoPosts(refresh: true),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (_homeStore.videoPosts.isEmpty && !_homeStore.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.video_library_outlined,
                    size: 64,
                    color: AppColors.darkGrayColor,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No videos yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.darkGrayColor,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => _homeStore.fetchVideoPosts(refresh: true),
            color: AppColors.primaryColor,
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 8.0 : 32.0,
                vertical: 8.0,
              ),
              itemCount: _homeStore.videoPosts.length +
                  (_homeStore.hasMorePosts ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _homeStore.videoPosts.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: LoadingWidget()),
                  );
                }

                final post = _homeStore.videoPosts[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: VideoPostCard(
                    post: post,
                    onLike: () => _homeStore.likePost(post.id),
                    onTap: () => context.push('/video/${post.id}'),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          AboutButton(
            onPressed: () => context.push('/about'),
          ),
          const SizedBox(height: 12),
          InquiryFAB(
            onPressed: () => context.push('/inquiry'),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerList(bool isMobile) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8.0 : 32.0,
        vertical: 8.0,
      ),
      itemCount: 4,
      itemBuilder: (_, __) => const Padding(
        padding: EdgeInsets.only(bottom: 16.0),
        child: VideoPostCardShimmer(),
      ),
    );
  }
}
