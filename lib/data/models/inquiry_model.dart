import 'package:equatable/equatable.dart';

enum InquiryStatus { pending, reviewed, contacted }

extension InquiryStatusExtension on InquiryStatus {
  String get value {
    switch (this) {
      case InquiryStatus.pending:
        return 'pending';
      case InquiryStatus.reviewed:
        return 'reviewed';
      case InquiryStatus.contacted:
        return 'contacted';
    }
  }

  static InquiryStatus fromString(String value) {
    switch (value) {
      case 'reviewed':
        return InquiryStatus.reviewed;
      case 'contacted':
        return InquiryStatus.contacted;
      default:
        return InquiryStatus.pending;
    }
  }
}

class Inquiry extends Equatable {
  final String? id;
  final String clientName;
  final String email;
  final String? phoneNumber;
  final String projectType;
  final String? message;
  final String? budgetRange;
  final String? timeline;
  final InquiryStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Inquiry({
    this.id,
    required this.clientName,
    required this.email,
    this.phoneNumber,
    required this.projectType,
    this.message,
    this.budgetRange,
    this.timeline,
    this.status = InquiryStatus.pending,
    this.createdAt,
    this.updatedAt,
  });

  factory Inquiry.fromJson(Map<String, dynamic> json) {
    return Inquiry(
      id: json['id'] as String?,
      clientName: json['client_name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String?,
      projectType: json['project_type'] as String,
      message: json['message'] as String?,
      budgetRange: json['budget_range'] as String?,
      timeline: json['timeline'] as String?,
      status: InquiryStatusExtension.fromString(
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
      'project_type': projectType,
      if (message != null) 'message': message,
      if (budgetRange != null) 'budget_range': budgetRange,
      if (timeline != null) 'timeline': timeline,
      'status': status.value,
    };
  }

  Inquiry copyWith({
    String? id,
    String? clientName,
    String? email,
    String? phoneNumber,
    String? projectType,
    String? message,
    String? budgetRange,
    String? timeline,
    InquiryStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Inquiry(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      projectType: projectType ?? this.projectType,
      message: message ?? this.message,
      budgetRange: budgetRange ?? this.budgetRange,
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
        projectType,
        message,
        budgetRange,
        timeline,
        status,
        createdAt,
        updatedAt,
      ];
}
