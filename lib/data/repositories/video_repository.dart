import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../models/video_post_model.dart';

class VideoRepository {
  final SupabaseClient _client = SupabaseConfig.client;

  Future<List<VideoPost>> getVideoPosts({
    int page = 0,
    int pageSize = 10,
  }) async {
    try {
      final offset = page * pageSize;
      final response = await _client
          .from('videos_posts')
          .select()
          .order('created_at', ascending: false)
          .range(offset, offset + pageSize - 1);

      return (response as List)
          .map((post) => VideoPost.fromJson(post as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch videos: $e');
    }
  }

  Future<VideoPost> getVideoPostById(String id) async {
    try {
      final response = await _client
          .from('videos_posts')
          .select()
          .eq('id', id)
          .single();

      return VideoPost.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to fetch video: $e');
    }
  }

  Future<void> likePost(String postId) async {
    try {
      final currentPost = await getVideoPostById(postId);
      await _client
          .from('videos_posts')
          .update({'likes': currentPost.likes + 1}).eq('id', postId);
    } catch (e) {
      throw Exception('Failed to like post: $e');
    }
  }

  Future<void> incrementViews(String postId) async {
    try {
      final currentPost = await getVideoPostById(postId);
      await _client
          .from('videos_posts')
          .update({'views': currentPost.views + 1}).eq('id', postId);
    } catch (e) {
      throw Exception('Failed to increment views: $e');
    }
  }

  Future<List<VideoPost>> searchVideos(String query) async {
    try {
      final response = await _client
          .from('videos_posts')
          .select()
          .ilike('title', '%$query%')
          .or('description.ilike.%$query%');

      return (response as List)
          .map((post) => VideoPost.fromJson(post as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to search videos: $e');
    }
  }

  Future<List<VideoPost>> getVideosByType(String videoType) async {
    try {
      final response = await _client
          .from('videos_posts')
          .select()
          .eq('video_type', videoType)
          .order('created_at', ascending: false);

      return (response as List)
          .map((post) => VideoPost.fromJson(post as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch videos by type: $e');
    }
  }
}
