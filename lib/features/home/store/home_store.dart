import 'package:mobx/mobx.dart';
import '../../../data/models/video_post_model.dart';
import '../../../data/repositories/video_repository.dart';
import '../../../config/app_constants.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final VideoRepository videoRepository;

  _HomeStore(this.videoRepository);

  @observable
  ObservableList<VideoPost> videoPosts = ObservableList<VideoPost>();

  @observable
  bool isLoading = false;

  @observable
  bool isRefreshing = false;

  @observable
  String? error;

  @observable
  int pageNumber = 0;

  @observable
  bool hasMorePosts = true;

  @observable
  bool useDemoData = true; // Toggle to use demo data during development

  @computed
  bool get isEmpty => videoPosts.isEmpty && !isLoading;

  @computed
  bool get hasError => error != null;

  @action
  Future<void> fetchVideoPosts({bool refresh = false}) async {
    if (isLoading) return;

    try {
      if (refresh) {
        isRefreshing = true;
        pageNumber = 0;
        videoPosts.clear();
        hasMorePosts = true;
        error = null;
      } else {
        isLoading = true;
        error = null;
      }

      List<VideoPost> posts;

      if (useDemoData) {
        // Use demo data for development
        await Future.delayed(const Duration(milliseconds: 800));
        final allDemo = VideoRepository.getDemoVideoPosts();
        final start = pageNumber * AppConstants.postsPerPage;
        final end = (start + AppConstants.postsPerPage).clamp(0, allDemo.length);
        posts = start < allDemo.length ? allDemo.sublist(start, end) : [];
      } else {
        posts = await videoRepository.getVideoPosts(page: pageNumber);
      }

      if (posts.isEmpty) {
        hasMorePosts = false;
      } else {
        videoPosts.addAll(posts);
        pageNumber++;
      }
    } catch (e) {
      error = 'Failed to load videos. Please try again.';
    } finally {
      isLoading = false;
      isRefreshing = false;
    }
  }

  @action
  Future<void> toggleLike(String postId) async {
    final index = videoPosts.indexWhere((p) => p.id == postId);
    if (index == -1) return;

    final post = videoPosts[index];
    final wasLiked = post.isLiked;

    // Optimistic update
    final updatedPost = post.copyWith(
      likes: wasLiked ? post.likes - 1 : post.likes + 1,
      isLiked: !wasLiked,
    );
    videoPosts[index] = updatedPost;

    try {
      if (!useDemoData) {
        if (wasLiked) {
          await videoRepository.unlikePost(postId);
        } else {
          await videoRepository.likePost(postId);
        }
      }
    } catch (e) {
      // Revert on failure
      videoPosts[index] = post;
      error = 'Failed to update like. Please try again.';
    }
  }

  @action
  void clearError() {
    error = null;
  }

  @action
  void initialize() {
    fetchVideoPosts();
  }
}
