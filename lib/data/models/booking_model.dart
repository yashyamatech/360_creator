import 'package:equatable/equatable.dart';

enum BookingStatus { pending, confirmed, completed, cancelled }

extension BookingStatusExtension on BookingStatus {
  String get value {
    switch (this) {
      case BookingStatus.pending:
        return 'pending';
      case BookingStatus.confirmed:
        return 'confirmed';
      case BookingStatus.completed:
        return 'completed';
      case BookingStatus.cancelled:
        return 'cancelled';
    }
  }

  String get label {
    switch (this) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  static BookingStatus fromString(String value) {
    switch (value) {
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'completed':
        return BookingStatus.completed;
      case 'cancelled':
        return BookingStatus.cancelled;
      default:
        return BookingStatus.pending;
    }
  }
}

class Booking extends Equatable {
  final String? id;
  final String clientName;
  final String email;
  final String? phoneNumber;
  final String? referenceVideoId;
  final String? projectRequirements;
  final String? budget;
  final String? timeline;
  final BookingStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Booking({
    this.id,
    required this.clientName,
    required this.email,
    this.phoneNumber,
    this.referenceVideoId,
    this.projectRequirements,
    this.budget,
    this.timeline,
    this.status = BookingStatus.pending,
    this.createdAt,
    this.updatedAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as String?,
      clientName: json['client_name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String?,
      referenceVideoId: json['reference_video_id'] as String?,
      projectRequirements: json['project_requirements'] as String?,
      budget: json['budget'] as String?,
      timeline: json['timeline'] as String?,
      status: BookingStatusExtension.fromString(
          (json['status'] as String?) ?? 'pending'),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'client_name': clientName,
      'email': email,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (referenceVideoId != null) 'reference_video_id': referenceVideoId,
      if (projectRequirements != null)
        'project_requirements': projectRequirements,
      if (budget != null) 'budget': budget,
      if (timeline != null) 'timeline': timeline,
      'status': status.value,
    };
  }

  Booking copyWith({
    String? id,
    String? clientName,
    String? email,
    String? phoneNumber,
    String? referenceVideoId,
    String? projectRequirements,
    String? budget,
    String? timeline,
    BookingStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Booking(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      referenceVideoId: referenceVideoId ?? this.referenceVideoId,
      projectRequirements: projectRequirements ?? this.projectRequirements,
      budget: budget ?? this.budget,
      timeline: timeline ?? this.timeline,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
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
