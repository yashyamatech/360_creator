import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../models/booking_model.dart';

class BookingRepository {
  final SupabaseClient _client = SupabaseConfig.client;

  Future<String> createBooking(Booking booking) async {
    try {
      final response = await _client
          .from('bookings')
          .insert(booking.toJson())
          .select()
          .single();

      return response['id'] as String;
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }

  Future<List<Booking>> getAllBookings() async {
    try {
      final response = await _client
          .from('bookings')
          .select()
          .order('created_at', ascending: false);

      return (response as List)
          .map((booking) => Booking.fromJson(booking as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch bookings: $e');
    }
  }

  Future<void> updateBookingStatus(String bookingId, String status) async {
    try {
      await _client.from('bookings').update({
        'status': status,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', bookingId);
    } catch (e) {
      throw Exception('Failed to update booking: $e');
    }
  }
}
