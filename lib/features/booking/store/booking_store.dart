import 'package:mobx/mobx.dart';
import '../../../data/models/booking_model.dart';
import '../../../data/repositories/booking_repository.dart';
import '../../../shared/utils/email_service.dart';

part 'booking_store.g.dart';

class BookingStore = _BookingStore with _$BookingStore;

abstract class _BookingStore with Store {
  final BookingRepository bookingRepository;
  final EmailService emailService;

  _BookingStore(this.bookingRepository, this.emailService);

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  bool isSuccess = false;

  @observable
  String? selectedVideoId;

  @action
  void selectVideo(String videoId) {
    selectedVideoId = videoId;
  }

  @action
  Future<void> submitBooking({
    required String clientName,
    required String email,
    required String? phoneNumber,
    required String? projectRequirements,
    required String? budget,
    required String? timeline,
  }) async {
    try {
      isLoading = true;
      error = null;
      isSuccess = false;

      final booking = Booking(
        id: '',
        clientName: clientName,
        email: email,
        phoneNumber: phoneNumber,
        referenceVideoId: selectedVideoId,
        projectRequirements: projectRequirements,
        budget: budget,
        timeline: timeline,
        createdAt: DateTime.now(),
      );

      await bookingRepository.createBooking(booking);

      await emailService.sendBookingConfirmationEmail(
        clientName: clientName,
        clientEmail: email,
        phoneNumber: phoneNumber,
        projectRequirements: projectRequirements,
        budget: budget,
        timeline: timeline,
      );

      isSuccess = true;
      isLoading = false;
    } catch (e) {
      error = e.toString();
      isLoading = false;
    }
  }

  @action
  void clearError() {
    error = null;
  }

  @action
  void resetForm() {
    isSuccess = false;
    error = null;
    selectedVideoId = null;
  }
}
