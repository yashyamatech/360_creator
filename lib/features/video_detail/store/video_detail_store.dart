import 'package:mobx/mobx.dart';
import '../../../data/models/video_post_model.dart';
import '../../../data/repositories/video_repository.dart';

part 'video_detail_store.g.dart';

class VideoDetailStore = _VideoDetailStore with _$VideoDetailStore;

abstract class _VideoDetailStore with Store {
  final VideoRepository videoRepository;

  _VideoDetailStore(this.videoRepository);

  @observable
  VideoPost? videoPost;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  bool isLiked = false;

  // ── Computed ─────────────────────────────────────────────────────────────
  @computed
  bool get hasPost => videoPost != null;

  @computed
  bool get hasError => error != null;

  // ── Actions ──────────────────────────────────────────────────────────────
  @action
  Future<void> fetchVideo(String id) async {
    isLoading = true;
    error = null;
    try {
      videoPost = await videoRepository.getVideoPostById(id);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> toggleLike() async {
    if (videoPost == null) return;
    try {
      await videoRepository.likePost(videoPost!.id);
      isLiked = !isLiked;
      videoPost = videoPost!.copyWith(
        likes: isLiked ? videoPost!.likes + 1 : videoPost!.likes - 1,
      );
    } catch (e) {
      error = e.toString();
    }
  }

  @action
  void clearError() {
    error = null;
  }
}
