import 'package:equatable/equatable.dart';

class VideoPost extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String videoUrl;
  final String? thumbnailUrl;
  final String agencyId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int views;
  final int likes;
  final String? videoType;
  final List<String> hashtags;
  final List<String> actorNames;
  final String? clientName;
  final String? projectDuration;
  final String? budgetRange;
  bool isLiked;

  VideoPost({
    required this.id,
    required this.title,
    this.description,
    required this.videoUrl,
    this.thumbnailUrl,
    required this.agencyId,
    required this.createdAt,
    required this.updatedAt,
    this.views = 0,
    this.likes = 0,
    this.videoType,
    this.hashtags = const [],
    this.actorNames = const [],
    this.clientName,
    this.projectDuration,
    this.budgetRange,
    this.isLiked = false,
  });

  factory VideoPost.fromJson(Map<String, dynamic> json) {
    return VideoPost(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      videoUrl: json['video_url'] as String,
      thumbnailUrl: json['thumbnail_url'] as String?,
      agencyId: json['agency_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      views: (json['views'] as int?) ?? 0,
      likes: (json['likes'] as int?) ?? 0,
      videoType: json['video_type'] as String?,
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      actorNames: (json['actor_names'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      clientName: json['client_name'] as String?,
      projectDuration: json['project_duration'] as String?,
      budgetRange: json['budget_range'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'video_url': videoUrl,
      'thumbnail_url': thumbnailUrl,
      'agency_id': agencyId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'views': views,
      'likes': likes,
      'video_type': videoType,
      'hashtags': hashtags,
      'actor_names': actorNames,
      'client_name': clientName,
      'project_duration': projectDuration,
      'budget_range': budgetRange,
    };
  }

  VideoPost copyWith({
    String? id,
    String? title,
    String? description,
    String? videoUrl,
    String? thumbnailUrl,
    String? agencyId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? views,
    int? likes,
    String? videoType,
    List<String>? hashtags,
    List<String>? actorNames,
    String? clientName,
    String? projectDuration,
    String? budgetRange,
    bool? isLiked,
  }) {
    return VideoPost(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      agencyId: agencyId ?? this.agencyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      videoType: videoType ?? this.videoType,
      hashtags: hashtags ?? this.hashtags,
      actorNames: actorNames ?? this.actorNames,
      clientName: clientName ?? this.clientName,
      projectDuration: projectDuration ?? this.projectDuration,
      budgetRange: budgetRange ?? this.budgetRange,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  String get videoTypeLabel {
    switch (videoType) {
      case 'creation':
        return 'Video Creation';
      case 'editing':
        return 'Video Editing';
      case 'both':
        return 'Creation & Editing';
      default:
        return videoType ?? 'General';
    }
  }

  String get formattedViews {
    if (views >= 1000000) {
      return '${(views / 1000000).toStringAsFixed(1)}M';
    } else if (views >= 1000) {
      return '${(views / 1000).toStringAsFixed(1)}K';
    }
    return views.toString();
  }

  String get formattedLikes {
    if (likes >= 1000000) {
      return '${(likes / 1000000).toStringAsFixed(1)}M';
    } else if (likes >= 1000) {
      return '${(likes / 1000).toStringAsFixed(1)}K';
    }
    return likes.toString();
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        videoUrl,
        thumbnailUrl,
        agencyId,
        createdAt,
        updatedAt,
        views,
        likes,
        videoType,
        hashtags,
        actorNames,
        clientName,
        projectDuration,
        budgetRange,
        isLiked,
      ];
}
