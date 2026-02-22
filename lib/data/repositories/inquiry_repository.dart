import 'package:logger/logger.dart';
import '../../config/app_constants.dart';
import '../../config/supabase_config.dart';
import '../models/inquiry_model.dart';

class InquiryRepository {
  final _logger = Logger();

  Future<Inquiry> submitInquiry(Inquiry inquiry) async {
    try {
      final response = await SupabaseConfig.client
          .from(AppConstants.inquiriesTable)
          .insert(inquiry.toJson())
          .select()
          .single();

      return Inquiry.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      _logger.e('Error submitting inquiry: $e');
      rethrow;
    }
  }

  Future<List<Inquiry>> getInquiries() async {
    try {
      final response = await SupabaseConfig.client
          .from(AppConstants.inquiriesTable)
          .select()
          .order('created_at', ascending: false);

      return (response as List<dynamic>)
          .map((json) => Inquiry.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.e('Error fetching inquiries: $e');
      rethrow;
    }
  }

  Future<Inquiry?> getInquiryById(String id) async {
    try {
      final response = await SupabaseConfig.client
          .from(AppConstants.inquiriesTable)
          .select()
          .eq('id', id)
          .single();

      return Inquiry.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      _logger.e('Error fetching inquiry by id: $e');
      rethrow;
    }
  }

  Future<void> updateInquiryStatus(String id, InquiryStatus status) async {
    try {
      await SupabaseConfig.client
          .from(AppConstants.inquiriesTable)
          .update({'status': status.value})
          .eq('id', id);
    } catch (e) {
      _logger.e('Error updating inquiry status: $e');
      rethrow;
    }
  }
}
