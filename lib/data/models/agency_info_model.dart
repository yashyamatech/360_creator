import 'package:equatable/equatable.dart';

class TeamMember extends Equatable {
  final String name;
  final String role;
  final String? bio;
  final String? imageUrl;
  final String? linkedinUrl;

  const TeamMember({
    required this.name,
    required this.role,
    this.bio,
    this.imageUrl,
    this.linkedinUrl,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      name: json['name'] as String,
      role: json['role'] as String,
      bio: json['bio'] as String?,
      imageUrl: json['image_url'] as String?,
      linkedinUrl: json['linkedin_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      if (bio != null) 'bio': bio,
      if (imageUrl != null) 'image_url': imageUrl,
      if (linkedinUrl != null) 'linkedin_url': linkedinUrl,
    };
  }

  @override
  List<Object?> get props => [name, role, bio, imageUrl, linkedinUrl];
}

class Testimonial extends Equatable {
  final String clientName;
  final String? company;
  final String message;
  final double? rating;
  final String? imageUrl;
  final String? projectType;

  const Testimonial({
    required this.clientName,
    this.company,
    required this.message,
    this.rating,
    this.imageUrl,
    this.projectType,
  });

  factory Testimonial.fromJson(Map<String, dynamic> json) {
    return Testimonial(
      clientName: json['client_name'] as String,
      company: json['company'] as String?,
      message: json['message'] as String,
      rating: (json['rating'] as num?)?.toDouble(),
      imageUrl: json['image_url'] as String?,
      projectType: json['project_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_name': clientName,
      if (company != null) 'company': company,
      'message': message,
      if (rating != null) 'rating': rating,
      if (imageUrl != null) 'image_url': imageUrl,
      if (projectType != null) 'project_type': projectType,
    };
  }

  @override
  List<Object?> get props =>
      [clientName, company, message, rating, imageUrl, projectType];
}

class AgencyInfo extends Equatable {
  final String id;
  final String companyName;
  final String? description;
  final String? phoneNumber;
  final String? email;
  final String? address;
  final String? website;
  final String? instagramUrl;
  final String? facebookUrl;
  final String? youtubeUrl;
  final String? linkedinUrl;
  final List<TeamMember> teamMembers;
  final List<Testimonial> testimonials;
  final String? missionStatement;
  final String? visionStatement;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AgencyInfo({
    required this.id,
    required this.companyName,
    this.description,
    this.phoneNumber,
    this.email,
    this.address,
    this.website,
    this.instagramUrl,
    this.facebookUrl,
    this.youtubeUrl,
    this.linkedinUrl,
    this.teamMembers = const [],
    this.testimonials = const [],
    this.missionStatement,
    this.visionStatement,
    this.createdAt,
    this.updatedAt,
  });

  factory AgencyInfo.fromJson(Map<String, dynamic> json) {
    return AgencyInfo(
      id: json['id'] as String,
      companyName: json['company_name'] as String,
      description: json['description'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      website: json['website'] as String?,
      instagramUrl: json['instagram_url'] as String?,
      facebookUrl: json['facebook_url'] as String?,
      youtubeUrl: json['youtube_url'] as String?,
      linkedinUrl: json['linkedin_url'] as String?,
      teamMembers: (json['team_members'] as List<dynamic>?)
              ?.map((e) => TeamMember.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      testimonials: (json['testimonials'] as List<dynamic>?)
              ?.map((e) => Testimonial.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      missionStatement: json['mission_statement'] as String?,
      visionStatement: json['vision_statement'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  static AgencyInfo get placeholder => AgencyInfo(
        id: 'placeholder',
        companyName: '360 Creator',
        description:
            'We are a creative agency specializing in social media content creation and video production. Our team of talented actors and filmmakers bring your brand story to life.',
        phoneNumber: '+1 (555) 360-0001',
        email: 'info@360creator.com',
        address: '123 Creator Street, Los Angeles, CA 90001',
        website: 'https://360creator.com',
        instagramUrl: 'https://instagram.com/360creator',
        facebookUrl: 'https://facebook.com/360creator',
        youtubeUrl: 'https://youtube.com/360creator',
        linkedinUrl: 'https://linkedin.com/company/360creator',
        missionStatement:
            'To empower brands through compelling visual storytelling that resonates with modern audiences.',
        visionStatement:
            'To be the leading creative force in social media content, setting trends and inspiring creativity worldwide.',
        teamMembers: [
          TeamMember(
            name: 'Alex Johnson',
            role: 'Creative Director',
            bio:
                'Award-winning director with 10+ years in commercial and social media production.',
          ),
          TeamMember(
            name: 'Sarah Chen',
            role: 'Lead Video Editor',
            bio:
                'Expert in post-production with a passion for storytelling through editing.',
          ),
          TeamMember(
            name: 'Marcus Williams',
            role: 'Content Strategist',
            bio:
                'Social media specialist with proven track record of viral campaigns.',
          ),
        ],
        testimonials: [
          Testimonial(
            clientName: 'Jennifer Park',
            company: 'FashionForward Inc.',
            message:
                '360 Creator transformed our brand identity. Their team is incredibly talented and professional. Our engagement increased by 300% after their campaign!',
            rating: 5,
            projectType: 'Video Creation',
          ),
          Testimonial(
            clientName: 'David Rodriguez',
            company: 'TechStart Labs',
            message:
                'Outstanding editing quality and attention to detail. They truly understood our vision and delivered beyond expectations.',
            rating: 5,
            projectType: 'Video Editing',
          ),
          Testimonial(
            clientName: 'Emma Thompson',
            company: 'Lifestyle Brands Co.',
            message:
                'Working with 360 Creator was a game-changer. Their creative approach and professional execution made our products shine.',
            rating: 4.5,
            projectType: 'Both',
          ),
        ],
      );

  @override
  List<Object?> get props => [
        id,
        companyName,
        description,
        phoneNumber,
        email,
        address,
        website,
        instagramUrl,
        facebookUrl,
        youtubeUrl,
        linkedinUrl,
        teamMembers,
        testimonials,
        missionStatement,
        visionStatement,
        createdAt,
        updatedAt,
      ];
}
