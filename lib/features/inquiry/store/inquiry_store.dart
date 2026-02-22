import 'package:mobx/mobx.dart';
import '../../../data/models/inquiry_model.dart';
import '../../../data/repositories/inquiry_repository.dart';

part 'inquiry_store.g.dart';

class InquiryStore = _InquiryStore with _$InquiryStore;

abstract class _InquiryStore with Store {
  final InquiryRepository inquiryRepository;

  _InquiryStore(this.inquiryRepository);

  // Form Fields
  @observable
  String clientName = '';

  @observable
  String email = '';

  @observable
  String phoneNumber = '';

  @observable
  String projectType = '';

  @observable
  String message = '';

  @observable
  String? budgetRange;

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
  String? projectTypeError;

  @observable
  String? messageError;

  @computed
  bool get isFormValid {
    return clientName.isNotEmpty &&
        email.isNotEmpty &&
        _isValidEmail(email) &&
        projectType.isNotEmpty &&
        message.isNotEmpty;
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
  void setProjectType(String value) {
    projectType = value;
    if (value.isNotEmpty) projectTypeError = null;
  }

  @action
  void setMessage(String value) {
    message = value;
    if (value.isNotEmpty) messageError = null;
  }

  @action
  void setBudgetRange(String? value) {
    budgetRange = value;
  }

  @action
  void setTimeline(String? value) {
    timeline = value;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
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

    if (projectType.isEmpty) {
      projectTypeError = 'Please select a project type';
      valid = false;
    }

    if (message.isEmpty) {
      messageError = 'Please enter your message or requirements';
      valid = false;
    }

    return valid;
  }

  @action
  Future<bool> submitInquiry() async {
    if (!validateForm()) return false;

    try {
      isSubmitting = true;
      error = null;

      final inquiry = Inquiry(
        clientName: clientName,
        email: email,
        phoneNumber: phoneNumber.isNotEmpty ? phoneNumber : null,
        projectType: projectType,
        message: message,
        budgetRange: budgetRange,
        timeline: timeline,
      );

      await inquiryRepository.submitInquiry(inquiry);

      isSubmitted = true;
      successMessage =
          'Thank you, $clientName! Your inquiry has been submitted. We\'ll be in touch within 24 hours.';
      resetForm();
      return true;
    } catch (e) {
      error = 'Failed to submit inquiry. Please try again or contact us directly.';
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
    projectType = '';
    message = '';
    budgetRange = null;
    timeline = null;
    clientNameError = null;
    emailError = null;
    projectTypeError = null;
    messageError = null;
  }

  @action
  void clearMessages() {
    error = null;
    successMessage = null;
    isSubmitted = false;
  }
}
