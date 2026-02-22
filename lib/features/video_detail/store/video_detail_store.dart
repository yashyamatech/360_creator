import 'package:mobx/mobx.dart';
import '../../../data/models/video_post_model.dart';
import '../../../data/repositories/video_repository.dart';

part 'video_detail_store.g.dart';

class VideoDetailStore = _VideoDetailStore with _$VideoDetailStore;

abstract class _VideoDetailStore with Store {
  final VideoRepository videoRepository;

  _VideoDetailStore(this.videoRepository);

  @observable
  VideoPost? currentPost;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  bool isPlaying = false;

  @observable
  bool isMuted = false;

  @observable
  double videoProgress = 0.0;

  @computed
  bool get hasPost => currentPost != null;

  @action
  void setPost(VideoPost post) {
    currentPost = post;
  }

  @action
  Future<void> fetchPost(String postId) async {
    try {
      isLoading = true;
      error = null;
      currentPost = await videoRepository.getVideoPostById(postId);
    } catch (e) {
      error = 'Failed to load video details. Please try again.';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> toggleLike() async {
    if (currentPost == null) return;

    final wasLiked = currentPost!.isLiked;
    currentPost = currentPost!.copyWith(
      likes: wasLiked ? currentPost!.likes - 1 : currentPost!.likes + 1,
      isLiked: !wasLiked,
    );

    try {
      if (wasLiked) {
        await videoRepository.unlikePost(currentPost!.id);
      } else {
        await videoRepository.likePost(currentPost!.id);
      }
    } catch (e) {
      // Revert
      currentPost = currentPost!.copyWith(
        likes: wasLiked ? currentPost!.likes + 1 : currentPost!.likes - 1,
        isLiked: wasLiked,
      );
      error = 'Failed to update like.';
    }
  }

  @action
  void togglePlayPause() {
    isPlaying = !isPlaying;
  }

  @action
  void toggleMute() {
    isMuted = !isMuted;
  }

  @action
  void updateVideoProgress(double progress) {
    videoProgress = progress;
  }

  @action
  Future<void> incrementViews() async {
    if (currentPost == null) return;
    try {
      await videoRepository.incrementViews(currentPost!.id);
      currentPost = currentPost!.copyWith(views: currentPost!.views + 1);
    } catch (e) {
      // Non-critical
    }
  }

  @action
  void clearError() {
    error = null;
  }

  @action
  void reset() {
    currentPost = null;
    isLoading = false;
    error = null;
    isPlaying = false;
    isMuted = false;
    videoProgress = 0.0;
  }
}
