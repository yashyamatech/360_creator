import 'package:logger/logger.dart';
import '../../config/app_constants.dart';
import '../../config/supabase_config.dart';
import '../models/booking_model.dart';

class BookingRepository {
  final _logger = Logger();

  Future<Booking> createBooking(Booking booking) async {
    try {
      final response = await SupabaseConfig.client
          .from(AppConstants.bookingsTable)
          .insert(booking.toJson())
          .select()
          .single();

      return Booking.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      _logger.e('Error creating booking: $e');
      rethrow;
    }
  }

  Future<List<Booking>> getBookings() async {
    try {
      final response = await SupabaseConfig.client
          .from(AppConstants.bookingsTable)
          .select()
          .order('created_at', ascending: false);

      return (response as List<dynamic>)
          .map((json) => Booking.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.e('Error fetching bookings: $e');
      rethrow;
    }
  }

  Future<Booking?> getBookingById(String id) async {
    try {
      final response = await SupabaseConfig.client
          .from(AppConstants.bookingsTable)
          .select()
          .eq('id', id)
          .single();

      return Booking.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      _logger.e('Error fetching booking by id: $e');
      rethrow;
    }
  }

  Future<void> updateBookingStatus(String id, BookingStatus status) async {
    try {
      await SupabaseConfig.client
          .from(AppConstants.bookingsTable)
          .update({'status': status.value})
          .eq('id', id);
    } catch (e) {
      _logger.e('Error updating booking status: $e');
      rethrow;
    }
  }
}
