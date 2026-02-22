import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final String id;
  final String clientName;
  final String email;
  final String? phoneNumber;
  final String? referenceVideoId;
  final String? projectRequirements;
  final String? budget;
  final String? timeline;
  final String status; // 'pending', 'confirmed', 'completed'
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Booking({
    required this.id,
    required this.clientName,
    required this.email,
    this.phoneNumber,
    this.referenceVideoId,
    this.projectRequirements,
    this.budget,
    this.timeline,
    this.status = 'pending',
    required this.createdAt,
    this.updatedAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? '',
      clientName: json['client_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'],
      referenceVideoId: json['reference_video_id'],
      projectRequirements: json['project_requirements'],
      budget: json['budget'],
      timeline: json['timeline'],
      status: json['status'] ?? 'pending',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_name': clientName,
      'email': email,
      'phone_number': phoneNumber,
      'reference_video_id': referenceVideoId,
      'project_requirements': projectRequirements,
      'budget': budget,
      'timeline': timeline,
    };
  }

  @override
  List<Object?> get props => [
        id,
        clientName,
        email,
        phoneNumber,
        referenceVideoId,
        projectRequirements,
        budget,
        timeline,
        status,
        createdAt,
        updatedAt,
      ];
}
