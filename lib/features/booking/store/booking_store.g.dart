// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

mixin _$BookingStore on _BookingStore, Store {
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_BookingStore.isFormValid'))
          .value;

  late final _$referenceVideoAtom =
      Atom(name: '_BookingStore.referenceVideo', context: context);

  @override
  VideoPost? get referenceVideo {
    _$referenceVideoAtom.reportRead();
    return super.referenceVideo;
  }

  @override
  set referenceVideo(VideoPost? value) {
    _$referenceVideoAtom.reportWrite(value, super.referenceVideo, () {
      super.referenceVideo = value;
    });
  }

  late final _$clientNameAtom =
      Atom(name: '_BookingStore.clientName', context: context);

  @override
  String get clientName {
    _$clientNameAtom.reportRead();
    return super.clientName;
  }

  @override
  set clientName(String value) {
    _$clientNameAtom.reportWrite(value, super.clientName, () {
      super.clientName = value;
    });
  }

  late final _$emailAtom =
      Atom(name: '_BookingStore.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$phoneNumberAtom =
      Atom(name: '_BookingStore.phoneNumber', context: context);

  @override
  String get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$projectRequirementsAtom =
      Atom(name: '_BookingStore.projectRequirements', context: context);

  @override
  String get projectRequirements {
    _$projectRequirementsAtom.reportRead();
    return super.projectRequirements;
  }

  @override
  set projectRequirements(String value) {
    _$projectRequirementsAtom.reportWrite(value, super.projectRequirements, () {
      super.projectRequirements = value;
    });
  }

  late final _$budgetAtom =
      Atom(name: '_BookingStore.budget', context: context);

  @override
  String? get budget {
    _$budgetAtom.reportRead();
    return super.budget;
  }

  @override
  set budget(String? value) {
    _$budgetAtom.reportWrite(value, super.budget, () {
      super.budget = value;
    });
  }

  late final _$timelineAtom =
      Atom(name: '_BookingStore.timeline', context: context);

  @override
  String? get timeline {
    _$timelineAtom.reportRead();
    return super.timeline;
  }

  @override
  set timeline(String? value) {
    _$timelineAtom.reportWrite(value, super.timeline, () {
      super.timeline = value;
    });
  }

  late final _$isSubmittingAtom =
      Atom(name: '_BookingStore.isSubmitting', context: context);

  @override
  bool get isSubmitting {
    _$isSubmittingAtom.reportRead();
    return super.isSubmitting;
  }

  @override
  set isSubmitting(bool value) {
    _$isSubmittingAtom.reportWrite(value, super.isSubmitting, () {
      super.isSubmitting = value;
    });
  }

  late final _$isSubmittedAtom =
      Atom(name: '_BookingStore.isSubmitted', context: context);

  @override
  bool get isSubmitted {
    _$isSubmittedAtom.reportRead();
    return super.isSubmitted;
  }

  @override
  set isSubmitted(bool value) {
    _$isSubmittedAtom.reportWrite(value, super.isSubmitted, () {
      super.isSubmitted = value;
    });
  }

  late final _$errorAtom =
      Atom(name: '_BookingStore.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$successMessageAtom =
      Atom(name: '_BookingStore.successMessage', context: context);

  @override
  String? get successMessage {
    _$successMessageAtom.reportRead();
    return super.successMessage;
  }

  @override
  set successMessage(String? value) {
    _$successMessageAtom.reportWrite(value, super.successMessage, () {
      super.successMessage = value;
    });
  }

  late final _$clientNameErrorAtom =
      Atom(name: '_BookingStore.clientNameError', context: context);

  @override
  String? get clientNameError {
    _$clientNameErrorAtom.reportRead();
    return super.clientNameError;
  }

  @override
  set clientNameError(String? value) {
    _$clientNameErrorAtom.reportWrite(value, super.clientNameError, () {
      super.clientNameError = value;
    });
  }

  late final _$emailErrorAtom =
      Atom(name: '_BookingStore.emailError', context: context);

  @override
  String? get emailError {
    _$emailErrorAtom.reportRead();
    return super.emailError;
  }

  @override
  set emailError(String? value) {
    _$emailErrorAtom.reportWrite(value, super.emailError, () {
      super.emailError = value;
    });
  }

  late final _$requirementsErrorAtom =
      Atom(name: '_BookingStore.requirementsError', context: context);

  @override
  String? get requirementsError {
    _$requirementsErrorAtom.reportRead();
    return super.requirementsError;
  }

  @override
  set requirementsError(String? value) {
    _$requirementsErrorAtom.reportWrite(value, super.requirementsError, () {
      super.requirementsError = value;
    });
  }

  late final _$submitBookingAsyncAction =
      AsyncAction('_BookingStore.submitBooking', context: context);

  @override
  Future<bool> submitBooking() {
    return _$submitBookingAsyncAction.run(() => super.submitBooking());
  }

  late final _$_BookingStoreActionController =
      ActionController(name: '_BookingStore', context: context);

  @override
  void setReferenceVideo(VideoPost? video) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.setReferenceVideo');
    try {
      return super.setReferenceVideo(video);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setClientName(String value) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.setClientName');
    try {
      return super.setClientName(value);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhoneNumber(String value) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.setPhoneNumber');
    try {
      return super.setPhoneNumber(value);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProjectRequirements(String value) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.setProjectRequirements');
    try {
      return super.setProjectRequirements(value);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBudget(String? value) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.setBudget');
    try {
      return super.setBudget(value);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTimeline(String? value) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.setTimeline');
    try {
      return super.setTimeline(value);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool validateForm() {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.validateForm');
    try {
      return super.validateForm();
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetForm() {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.resetForm');
    try {
      return super.resetForm();
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearMessages() {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.clearMessages');
    try {
      return super.clearMessages();
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }
}
