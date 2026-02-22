// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  Computed<int>? _$totalPostsComputed;

  @override
  int get totalPosts =>
      (_$totalPostsComputed ??= Computed<int>(() => super.totalPosts,
              name: '_HomeStore.totalPosts'))
          .value;

  Computed<int>? _$totalLikesComputed;

  @override
  int get totalLikes =>
      (_$totalLikesComputed ??= Computed<int>(() => super.totalLikes,
              name: '_HomeStore.totalLikes'))
          .value;

  late final _$videoPostsAtom =
      Atom(name: '_HomeStore.videoPosts', context: context);

  @override
  ObservableList<VideoPost> get videoPosts {
    _$videoPostsAtom.reportRead();
    return super.videoPosts;
  }

  @override
  set videoPosts(ObservableList<VideoPost> value) {
    _$videoPostsAtom.reportWrite(value, super.videoPosts, () {
      super.videoPosts = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_HomeStore.isLoading', context: context);

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

  late final _$errorAtom = Atom(name: '_HomeStore.error', context: context);

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

  late final _$pageNumberAtom =
      Atom(name: '_HomeStore.pageNumber', context: context);

  @override
  int get pageNumber {
    _$pageNumberAtom.reportRead();
    return super.pageNumber;
  }

  @override
  set pageNumber(int value) {
    _$pageNumberAtom.reportWrite(value, super.pageNumber, () {
      super.pageNumber = value;
    });
  }

  late final _$hasMorePostsAtom =
      Atom(name: '_HomeStore.hasMorePosts', context: context);

  @override
  bool get hasMorePosts {
    _$hasMorePostsAtom.reportRead();
    return super.hasMorePosts;
  }

  @override
  set hasMorePosts(bool value) {
    _$hasMorePostsAtom.reportWrite(value, super.hasMorePosts, () {
      super.hasMorePosts = value;
    });
  }

  late final _$isRefreshingAtom =
      Atom(name: '_HomeStore.isRefreshing', context: context);

  @override
  bool get isRefreshing {
    _$isRefreshingAtom.reportRead();
    return super.isRefreshing;
  }

  @override
  set isRefreshing(bool value) {
    _$isRefreshingAtom.reportWrite(value, super.isRefreshing, () {
      super.isRefreshing = value;
    });
  }

  late final _$fetchVideoPostsAsyncAction =
      AsyncAction('_HomeStore.fetchVideoPosts', context: context);

  @override
  Future<void> fetchVideoPosts({bool refresh = false}) {
    return _$fetchVideoPostsAsyncAction
        .run(() => super.fetchVideoPosts(refresh: refresh));
  }

  late final _$likePostAsyncAction =
      AsyncAction('_HomeStore.likePost', context: context);

  @override
  Future<void> likePost(String postId) {
    return _$likePostAsyncAction.run(() => super.likePost(postId));
  }

  late final _$_HomeStoreActionController =
      ActionController(name: '_HomeStore', context: context);

  @override
  void clearError() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.clearError');
    try {
      return super.clearError();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
videoPosts: ${videoPosts},
isLoading: ${isLoading},
error: ${error},
pageNumber: ${pageNumber},
hasMorePosts: ${hasMorePosts},
isRefreshing: ${isRefreshing},
totalPosts: ${totalPosts},
totalLikes: ${totalLikes}
    ''';
  }
}
