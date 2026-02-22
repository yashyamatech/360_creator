import 'package:equatable/equatable.dart';

class Inquiry extends Equatable {
  final String id;
  final String clientName;
  final String email;
  final String? phoneNumber;
  final String projectType;
  final String? message;
  final String? budgetRange;
  final String? timeline;
  final String status; // 'pending', 'reviewed', 'contacted'
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Inquiry({
    required this.id,
    required this.clientName,
    required this.email,
    this.phoneNumber,
    required this.projectType,
    this.message,
    this.budgetRange,
    this.timeline,
    this.status = 'pending',
    required this.createdAt,
    this.updatedAt,
  });

  factory Inquiry.fromJson(Map<String, dynamic> json) {
    return Inquiry(
      id: json['id'] ?? '',
      clientName: json['client_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'],
      projectType: json['project_type'] ?? '',
      message: json['message'],
      budgetRange: json['budget_range'],
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
      'project_type': projectType,
      'message': message,
      'budget_range': budgetRange,
      'timeline': timeline,
      'status': status,
    };
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
