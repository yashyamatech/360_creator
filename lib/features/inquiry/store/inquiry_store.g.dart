// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inquiry_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

mixin _$InquiryStore on _InquiryStore, Store {
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_InquiryStore.isFormValid'))
          .value;

  late final _$clientNameAtom =
      Atom(name: '_InquiryStore.clientName', context: context);

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
      Atom(name: '_InquiryStore.email', context: context);

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
      Atom(name: '_InquiryStore.phoneNumber', context: context);

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

  late final _$projectTypeAtom =
      Atom(name: '_InquiryStore.projectType', context: context);

  @override
  String get projectType {
    _$projectTypeAtom.reportRead();
    return super.projectType;
  }

  @override
  set projectType(String value) {
    _$projectTypeAtom.reportWrite(value, super.projectType, () {
      super.projectType = value;
    });
  }

  late final _$messageAtom =
      Atom(name: '_InquiryStore.message', context: context);

  @override
  String get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  late final _$budgetRangeAtom =
      Atom(name: '_InquiryStore.budgetRange', context: context);

  @override
  String? get budgetRange {
    _$budgetRangeAtom.reportRead();
    return super.budgetRange;
  }

  @override
  set budgetRange(String? value) {
    _$budgetRangeAtom.reportWrite(value, super.budgetRange, () {
      super.budgetRange = value;
    });
  }

  late final _$timelineAtom =
      Atom(name: '_InquiryStore.timeline', context: context);

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
      Atom(name: '_InquiryStore.isSubmitting', context: context);

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
      Atom(name: '_InquiryStore.isSubmitted', context: context);

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
      Atom(name: '_InquiryStore.error', context: context);

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
      Atom(name: '_InquiryStore.successMessage', context: context);

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
      Atom(name: '_InquiryStore.clientNameError', context: context);

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
      Atom(name: '_InquiryStore.emailError', context: context);

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

  late final _$projectTypeErrorAtom =
      Atom(name: '_InquiryStore.projectTypeError', context: context);

  @override
  String? get projectTypeError {
    _$projectTypeErrorAtom.reportRead();
    return super.projectTypeError;
  }

  @override
  set projectTypeError(String? value) {
    _$projectTypeErrorAtom.reportWrite(value, super.projectTypeError, () {
      super.projectTypeError = value;
    });
  }

  late final _$messageErrorAtom =
      Atom(name: '_InquiryStore.messageError', context: context);

  @override
  String? get messageError {
    _$messageErrorAtom.reportRead();
    return super.messageError;
  }

  @override
  set messageError(String? value) {
    _$messageErrorAtom.reportWrite(value, super.messageError, () {
      super.messageError = value;
    });
  }

  late final _$submitInquiryAsyncAction =
      AsyncAction('_InquiryStore.submitInquiry', context: context);

  @override
  Future<bool> submitInquiry() {
    return _$submitInquiryAsyncAction.run(() => super.submitInquiry());
  }

  late final _$_InquiryStoreActionController =
      ActionController(name: '_InquiryStore', context: context);

  @override
  void setClientName(String value) {
    final _$actionInfo = _$_InquiryStoreActionController.startAction(
        name: '_InquiryStore.setClientName');
    try {
      return super.setClientName(value);
    } finally {
      _$_InquiryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_InquiryStoreActionController.startAction(
        name: '_InquiryStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_InquiryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhoneNumber(String value) {
    final _$actionInfo = _$_InquiryStoreActionController.startAction(
        name: '_InquiryStore.setPhoneNumber');
    try {
      return super.setPhoneNumber(value);
    } finally {
      _$_InquiryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProjectType(String value) {
    final _$actionInfo = _$_InquiryStoreActionController.startAction(
        name: '_InquiryStore.setProjectType');
    try {
      return super.setProjectType(value);
    } finally {
      _$_InquiryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMessage(String value) {
    final _$actionInfo = _$_InquiryStoreActionController.startAction(
        name: '_InquiryStore.setMessage');
    try {
      return super.setMessage(value);
    } finally {
      _$_InquiryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBudgetRange(String? value) {
    final _$actionInfo = _$_InquiryStoreActionController.startAction(
        name: '_InquiryStore.setBudgetRange');
    try {
      return super.setBudgetRange(value);
    } finally {
      _$_InquiryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTimeline(String? value) {
    final _$actionInfo = _$_InquiryStoreActionController.startAction(
        name: '_InquiryStore.setTimeline');
    try {
      return super.setTimeline(value);
    } finally {
      _$_InquiryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool validateForm() {
    final _$actionInfo = _$_InquiryStoreActionController.startAction(
        name: '_InquiryStore.validateForm');
    try {
      return super.validateForm();
    } finally {
      _$_InquiryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetForm() {
    final _$actionInfo = _$_InquiryStoreActionController.startAction(
        name: '_InquiryStore.resetForm');
    try {
      return super.resetForm();
    } finally {
      _$_InquiryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearMessages() {
    final _$actionInfo = _$_InquiryStoreActionController.startAction(
        name: '_InquiryStore.clearMessages');
    try {
      return super.clearMessages();
    } finally {
      _$_InquiryStoreActionController.endAction(_$actionInfo);
    }
  }
}
