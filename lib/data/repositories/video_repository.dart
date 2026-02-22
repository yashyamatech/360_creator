import 'package:logger/logger.dart';
import '../../config/app_constants.dart';
import '../../config/supabase_config.dart';
import '../models/video_post_model.dart';

class VideoRepository {
  final _logger = Logger();

  Future<List<VideoPost>> getVideoPosts({
    int page = 0,
    int limit = AppConstants.postsPerPage,
  }) async {
    try {
      final response = await SupabaseConfig.client
          .from(AppConstants.videoPostsTable)
          .select()
          .order('created_at', ascending: false)
          .range(page * limit, (page + 1) * limit - 1);

      return (response as List<dynamic>)
          .map((json) => VideoPost.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.e('Error fetching video posts: $e');
      rethrow;
    }
  }

  Future<VideoPost?> getVideoPostById(String id) async {
    try {
      final response = await SupabaseConfig.client
          .from(AppConstants.videoPostsTable)
          .select()
          .eq('id', id)
          .single();

      return VideoPost.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      _logger.e('Error fetching video post by id: $e');
      rethrow;
    }
  }

  Future<void> incrementViews(String postId) async {
    try {
      await SupabaseConfig.client.rpc(
        'increment_video_views',
        params: {'post_id': postId},
      );
    } catch (e) {
      _logger.w('Error incrementing views: $e');
      // Non-critical, don't rethrow
    }
  }

  Future<void> likePost(String postId) async {
    try {
      await SupabaseConfig.client.rpc(
        'increment_video_likes',
        params: {'post_id': postId},
      );
    } catch (e) {
      _logger.e('Error liking post: $e');
      rethrow;
    }
  }

  Future<void> unlikePost(String postId) async {
    try {
      await SupabaseConfig.client.rpc(
        'decrement_video_likes',
        params: {'post_id': postId},
      );
    } catch (e) {
      _logger.e('Error unliking post: $e');
      rethrow;
    }
  }

  Future<List<VideoPost>> searchVideoPosts(String query) async {
    try {
      final response = await SupabaseConfig.client
          .from(AppConstants.videoPostsTable)
          .select()
          .or('title.ilike.%$query%,description.ilike.%$query%')
          .order('created_at', ascending: false)
          .limit(20);

      return (response as List<dynamic>)
          .map((json) => VideoPost.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.e('Error searching video posts: $e');
      rethrow;
    }
  }

  Future<List<VideoPost>> getVideoPostsByType(String videoType) async {
    try {
      final response = await SupabaseConfig.client
          .from(AppConstants.videoPostsTable)
          .select()
          .eq('video_type', videoType)
          .order('created_at', ascending: false)
          .limit(20);

      return (response as List<dynamic>)
          .map((json) => VideoPost.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.e('Error fetching video posts by type: $e');
      rethrow;
    }
  }

  // Demo data for development/testing
  static List<VideoPost> getDemoVideoPosts() {
    final now = DateTime.now();
    return [
      VideoPost(
        id: '1',
        title: 'Brand Campaign - Summer Collection',
        description:
            'An energetic campaign showcasing the summer fashion line with dynamic actors and vibrant locations.',
        videoUrl: 'https://example.com/videos/summer-campaign.mp4',
        thumbnailUrl: 'https://picsum.photos/seed/video1/400/300',
        agencyId: 'agency-1',
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(days: 2)),
        views: 15420,
        likes: 1230,
        videoType: 'creation',
        hashtags: ['#summer', '#fashion', '#brand', '#campaign'],
        actorNames: ['Sarah M.', 'Jake T.'],
        clientName: 'FashionForward Inc.',
        projectDuration: '3 weeks',
        budgetRange: '\$5,000 - \$10,000',
      ),
      VideoPost(
        id: '2',
        title: 'Product Launch - Tech Startup',
        description:
            'Sleek and modern product video highlighting innovative features for a leading tech startup.',
        videoUrl: 'https://example.com/videos/tech-launch.mp4',
        thumbnailUrl: 'https://picsum.photos/seed/video2/400/300',
        agencyId: 'agency-1',
        createdAt: now.subtract(const Duration(days: 5)),
        updatedAt: now.subtract(const Duration(days: 5)),
        views: 8930,
        likes: 567,
        videoType: 'editing',
        hashtags: ['#tech', '#startup', '#innovation', '#product'],
        actorNames: ['Alex R.'],
        clientName: 'TechStart Labs',
        projectDuration: '1 week',
        budgetRange: '\$1,000 - \$5,000',
      ),
      VideoPost(
        id: '3',
        title: 'Restaurant Promo - Fine Dining Experience',
        description:
            'A cinematic journey through culinary excellence, showcasing the restaurant\'s signature dishes.',
        videoUrl: 'https://example.com/videos/restaurant-promo.mp4',
        thumbnailUrl: 'https://picsum.photos/seed/video3/400/300',
        agencyId: 'agency-1',
        createdAt: now.subtract(const Duration(days: 8)),
        updatedAt: now.subtract(const Duration(days: 8)),
        views: 22150,
        likes: 1890,
        videoType: 'both',
        hashtags: ['#food', '#finedining', '#restaurant', '#culinary'],
        actorNames: ['Emma L.', 'Marcus J.'],
        clientName: 'Le Gourmet Restaurant',
        projectDuration: '2 weeks',
        budgetRange: '\$5,000 - \$10,000',
      ),
      VideoPost(
        id: '4',
        title: 'Fitness Brand - Motivation Series',
        description:
            'High-energy workout videos featuring professional athletes to inspire and motivate.',
        videoUrl: 'https://example.com/videos/fitness-brand.mp4',
        thumbnailUrl: 'https://picsum.photos/seed/video4/400/300',
        agencyId: 'agency-1',
        createdAt: now.subtract(const Duration(days: 12)),
        updatedAt: now.subtract(const Duration(days: 12)),
        views: 45600,
        likes: 3450,
        videoType: 'creation',
        hashtags: ['#fitness', '#motivation', '#workout', '#health'],
        actorNames: ['Chris A.', 'Dana P.', 'Ryan K.'],
        clientName: 'FitLife Brands',
        projectDuration: '4 weeks',
        budgetRange: '\$10,000+',
      ),
      VideoPost(
        id: '5',
        title: 'Real Estate Showcase - Luxury Properties',
        description:
            'Elegant property walkthrough videos that captivate potential buyers with stunning visuals.',
        videoUrl: 'https://example.com/videos/real-estate.mp4',
        thumbnailUrl: 'https://picsum.photos/seed/video5/400/300',
        agencyId: 'agency-1',
        createdAt: now.subtract(const Duration(days: 15)),
        updatedAt: now.subtract(const Duration(days: 15)),
        views: 12300,
        likes: 890,
        videoType: 'both',
        hashtags: ['#realestate', '#luxury', '#property', '#homes'],
        actorNames: ['Jessica N.'],
        clientName: 'Prestige Realty',
        projectDuration: '1 week',
        budgetRange: '\$5,000 - \$10,000',
      ),
      VideoPost(
        id: '6',
        title: 'Beauty Brand - Skincare Routine',
        description:
            'Glowing tutorials and lifestyle content for a premium skincare brand.',
        videoUrl: 'https://example.com/videos/beauty-brand.mp4',
        thumbnailUrl: 'https://picsum.photos/seed/video6/400/300',
        agencyId: 'agency-1',
        createdAt: now.subtract(const Duration(days: 20)),
        updatedAt: now.subtract(const Duration(days: 20)),
        views: 33800,
        likes: 2760,
        videoType: 'creation',
        hashtags: ['#beauty', '#skincare', '#glow', '#selfcare'],
        actorNames: ['Mia F.', 'Zoe B.'],
        clientName: 'LuxBeauty Co.',
        projectDuration: '3 weeks',
        budgetRange: '\$5,000 - \$10,000',
      ),
    ];
  }
}
