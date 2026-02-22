import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../models/inquiry_model.dart';

class InquiryRepository {
  final SupabaseClient _client = SupabaseConfig.client;

  Future<String> createInquiry(Inquiry inquiry) async {
    try {
      final response = await _client
          .from('inquiries')
          .insert(inquiry.toJson())
          .select()
          .single();

      return response['id'] as String;
    } catch (e) {
      throw Exception('Failed to create inquiry: $e');
    }
  }

  Future<List<Inquiry>> getAllInquiries() async {
    try {
      final response = await _client
          .from('inquiries')
          .select()
          .order('created_at', ascending: false);

      return (response as List)
          .map((inquiry) => Inquiry.fromJson(inquiry as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch inquiries: $e');
    }
  }

  Future<void> updateInquiryStatus(String inquiryId, String status) async {
    try {
      await _client.from('inquiries').update({
        'status': status,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', inquiryId);
    } catch (e) {
      throw Exception('Failed to update inquiry: $e');
    }
  }
}
