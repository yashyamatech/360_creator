// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

mixin _$VideoDetailStore on _VideoDetailStore, Store {
  Computed<bool>? _$hasPostComputed;

  @override
  bool get hasPost =>
      (_$hasPostComputed ??= Computed<bool>(() => super.hasPost,
              name: '_VideoDetailStore.hasPost'))
          .value;

  late final _$currentPostAtom =
      Atom(name: '_VideoDetailStore.currentPost', context: context);

  @override
  VideoPost? get currentPost {
    _$currentPostAtom.reportRead();
    return super.currentPost;
  }

  @override
  set currentPost(VideoPost? value) {
    _$currentPostAtom.reportWrite(value, super.currentPost, () {
      super.currentPost = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_VideoDetailStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorAtom =
      Atom(name: '_VideoDetailStore.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$isPlayingAtom =
      Atom(name: '_VideoDetailStore.isPlaying', context: context);

  @override
  bool get isPlaying {
    _$isPlayingAtom.reportRead();
    return super.isPlaying;
  }

  @override
  set isPlaying(bool value) {
    _$isPlayingAtom.reportWrite(value, super.isPlaying, () {
      super.isPlaying = value;
    });
  }

  late final _$isMutedAtom =
      Atom(name: '_VideoDetailStore.isMuted', context: context);

  @override
  bool get isMuted {
    _$isMutedAtom.reportRead();
    return super.isMuted;
  }

  @override
  set isMuted(bool value) {
    _$isMutedAtom.reportWrite(value, super.isMuted, () {
      super.isMuted = value;
    });
  }

  late final _$videoProgressAtom =
      Atom(name: '_VideoDetailStore.videoProgress', context: context);

  @override
  double get videoProgress {
    _$videoProgressAtom.reportRead();
    return super.videoProgress;
  }

  @override
  set videoProgress(double value) {
    _$videoProgressAtom.reportWrite(value, super.videoProgress, () {
      super.videoProgress = value;
    });
  }

  late final _$fetchPostAsyncAction =
      AsyncAction('_VideoDetailStore.fetchPost', context: context);

  @override
  Future<void> fetchPost(String postId) {
    return _$fetchPostAsyncAction.run(() => super.fetchPost(postId));
  }

  late final _$toggleLikeAsyncAction =
      AsyncAction('_VideoDetailStore.toggleLike', context: context);

  @override
  Future<void> toggleLike() {
    return _$toggleLikeAsyncAction.run(() => super.toggleLike());
  }

  late final _$incrementViewsAsyncAction =
      AsyncAction('_VideoDetailStore.incrementViews', context: context);

  @override
  Future<void> incrementViews() {
    return _$incrementViewsAsyncAction.run(() => super.incrementViews());
  }

  late final _$_VideoDetailStoreActionController =
      ActionController(name: '_VideoDetailStore', context: context);

  @override
  void setPost(VideoPost post) {
    final _$actionInfo = _$_VideoDetailStoreActionController.startAction(
        name: '_VideoDetailStore.setPost');
    try {
      return super.setPost(post);
    } finally {
      _$_VideoDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void togglePlayPause() {
    final _$actionInfo = _$_VideoDetailStoreActionController.startAction(
        name: '_VideoDetailStore.togglePlayPause');
    try {
      return super.togglePlayPause();
    } finally {
      _$_VideoDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleMute() {
    final _$actionInfo = _$_VideoDetailStoreActionController.startAction(
        name: '_VideoDetailStore.toggleMute');
    try {
      return super.toggleMute();
    } finally {
      _$_VideoDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateVideoProgress(double progress) {
    final _$actionInfo = _$_VideoDetailStoreActionController.startAction(
        name: '_VideoDetailStore.updateVideoProgress');
    try {
      return super.updateVideoProgress(progress);
    } finally {
      _$_VideoDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearError() {
    final _$actionInfo = _$_VideoDetailStoreActionController.startAction(
        name: '_VideoDetailStore.clearError');
    try {
      return super.clearError();
    } finally {
      _$_VideoDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_VideoDetailStoreActionController.startAction(
        name: '_VideoDetailStore.reset');
    try {
      return super.reset();
    } finally {
      _$_VideoDetailStoreActionController.endAction(_$actionInfo);
    }
  }
}
