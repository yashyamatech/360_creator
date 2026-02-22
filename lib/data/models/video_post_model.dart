import 'package:equatable/equatable.dart';

class VideoPost extends Equatable {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final String agencyId;
  final String? clientName;
  final int views;
  final int likes;
  final String videoType; // 'creation', 'editing', 'both'
  final List<String> hashtags;
  final List<String> actorNames;
  final String? projectDuration;
  final String? budgetRange;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const VideoPost({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.agencyId,
    this.clientName,
    required this.views,
    required this.likes,
    required this.videoType,
    required this.hashtags,
    required this.actorNames,
    this.projectDuration,
    this.budgetRange,
    required this.createdAt,
    this.updatedAt,
  });

  factory VideoPost.fromJson(Map<String, dynamic> json) {
    return VideoPost(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      videoUrl: json['video_url'] ?? '',
      thumbnailUrl: json['thumbnail_url'] ?? '',
      agencyId: json['agency_id'] ?? '',
      clientName: json['client_name'],
      views: json['views'] ?? 0,
      likes: json['likes'] ?? 0,
      videoType: json['video_type'] ?? 'creation',
      hashtags: List<String>.from(json['hashtags'] ?? []),
      actorNames: List<String>.from(json['actor_names'] ?? []),
      projectDuration: json['project_duration'],
      budgetRange: json['budget_range'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
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
      'client_name': clientName,
      'views': views,
      'likes': likes,
      'video_type': videoType,
      'hashtags': hashtags,
      'actor_names': actorNames,
      'project_duration': projectDuration,
      'budget_range': budgetRange,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  VideoPost copyWith({
    String? id,
    String? title,
    String? description,
    String? videoUrl,
    String? thumbnailUrl,
    String? agencyId,
    String? clientName,
    int? views,
    int? likes,
    String? videoType,
    List<String>? hashtags,
    List<String>? actorNames,
    String? projectDuration,
    String? budgetRange,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VideoPost(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      agencyId: agencyId ?? this.agencyId,
      clientName: clientName ?? this.clientName,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      videoType: videoType ?? this.videoType,
      hashtags: hashtags ?? this.hashtags,
      actorNames: actorNames ?? this.actorNames,
      projectDuration: projectDuration ?? this.projectDuration,
      budgetRange: budgetRange ?? this.budgetRange,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        videoUrl,
        thumbnailUrl,
        agencyId,
        clientName,
        views,
        likes,
        videoType,
        hashtags,
        actorNames,
        projectDuration,
        budgetRange,
        createdAt,
        updatedAt,
      ];
}
