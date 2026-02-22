import 'package:mobx/mobx.dart';
import '../../../data/models/booking_model.dart';
import '../../../data/models/video_post_model.dart';
import '../../../data/repositories/booking_repository.dart';

part 'booking_store.g.dart';

class BookingStore = _BookingStore with _$BookingStore;

abstract class _BookingStore with Store {
  final BookingRepository bookingRepository;

  _BookingStore(this.bookingRepository);

  // Reference video
  @observable
  VideoPost? referenceVideo;

  // Form Fields
  @observable
  String clientName = '';

  @observable
  String email = '';

  @observable
  String phoneNumber = '';

  @observable
  String projectRequirements = '';

  @observable
  String? budget;

  @observable
  String? timeline;

  // State
  @observable
  bool isSubmitting = false;

  @observable
  bool isSubmitted = false;

  @observable
  String? error;

  @observable
  String? successMessage;

  // Validation errors
  @observable
  String? clientNameError;

  @observable
  String? emailError;

  @observable
  String? requirementsError;

  @computed
  bool get isFormValid {
    return clientName.isNotEmpty &&
        email.isNotEmpty &&
        _isValidEmail(email) &&
        projectRequirements.isNotEmpty;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  @action
  void setReferenceVideo(VideoPost? video) {
    referenceVideo = video;
  }

  @action
  void setClientName(String value) {
    clientName = value;
    if (value.isNotEmpty) clientNameError = null;
  }

  @action
  void setEmail(String value) {
    email = value;
    if (value.isNotEmpty && _isValidEmail(value)) emailError = null;
  }

  @action
  void setPhoneNumber(String value) {
    phoneNumber = value;
  }

  @action
  void setProjectRequirements(String value) {
    projectRequirements = value;
    if (value.isNotEmpty) requirementsError = null;
  }

  @action
  void setBudget(String? value) {
    budget = value;
  }

  @action
  void setTimeline(String? value) {
    timeline = value;
  }

  @action
  bool validateForm() {
    bool valid = true;

    if (clientName.isEmpty) {
      clientNameError = 'Please enter your name';
      valid = false;
    }

    if (email.isEmpty) {
      emailError = 'Please enter your email';
      valid = false;
    } else if (!_isValidEmail(email)) {
      emailError = 'Please enter a valid email address';
      valid = false;
    }

    if (projectRequirements.isEmpty) {
      requirementsError = 'Please describe your project requirements';
      valid = false;
    }

    return valid;
  }

  @action
  Future<bool> submitBooking() async {
    if (!validateForm()) return false;

    try {
      isSubmitting = true;
      error = null;

      final booking = Booking(
        clientName: clientName,
        email: email,
        phoneNumber: phoneNumber.isNotEmpty ? phoneNumber : null,
        referenceVideoId: referenceVideo?.id,
        projectRequirements: projectRequirements,
        budget: budget,
        timeline: timeline,
      );

      await bookingRepository.createBooking(booking);

      isSubmitted = true;
      successMessage =
          'Booking submitted successfully, $clientName! We\'ll confirm your booking within 24 hours.';
      resetForm();
      return true;
    } catch (e) {
      error = 'Failed to submit booking. Please try again or contact us directly.';
      return false;
    } finally {
      isSubmitting = false;
    }
  }

  @action
  void resetForm() {
    clientName = '';
    email = '';
    phoneNumber = '';
    projectRequirements = '';
    budget = null;
    timeline = null;
    clientNameError = null;
    emailError = null;
    requirementsError = null;
  }

  @action
  void clearMessages() {
    error = null;
    successMessage = null;
    isSubmitted = false;
  }
}
