import 'package:mobx/mobx.dart';
import '../../../data/models/video_post_model.dart';
import '../../../data/repositories/video_repository.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final VideoRepository videoRepository;

  _HomeStore(this.videoRepository) {
    fetchVideoPosts();
  }

  @observable
  ObservableList<VideoPost> videoPosts = ObservableList<VideoPost>();

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  int pageNumber = 0;

  @observable
  bool hasMorePosts = true;

  @observable
  bool isRefreshing = false;

  @action
  Future<void> fetchVideoPosts({bool refresh = false}) async {
    try {
      if (refresh) {
        isRefreshing = true;
        pageNumber = 0;
        videoPosts.clear();
        hasMorePosts = true;
      } else {
        isLoading = true;
      }

      error = null;

      final posts = await videoRepository.getVideoPosts(page: pageNumber);

      if (posts.isEmpty) {
        hasMorePosts = false;
      } else {
        videoPosts.addAll(posts);
        pageNumber++;
      }

      isLoading = false;
      isRefreshing = false;
    } catch (e) {
      error = e.toString();
      isLoading = false;
      isRefreshing = false;
    }
  }

  @action
  Future<void> likePost(String postId) async {
    try {
      await videoRepository.likePost(postId);
      final index = videoPosts.indexWhere((p) => p.id == postId);
      if (index != -1) {
        videoPosts[index] = videoPosts[index].copyWith(
          likes: videoPosts[index].likes + 1,
        );
      }
    } catch (e) {
      error = e.toString();
    }
  }

  @action
  void clearError() {
    error = null;
  }

  void dispose() {
    videoPosts.clear();
  }

  @computed
  int get totalPosts => videoPosts.length;

  @computed
  int get totalLikes => videoPosts.fold(0, (sum, post) => sum + post.likes);
}
