// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inquiry_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InquiryStore on _InquiryStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_InquiryStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
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

  late final _$isSuccessAtom =
      Atom(name: '_InquiryStore.isSuccess', context: context);

  @override
  bool get isSuccess {
    _$isSuccessAtom.reportRead();
    return super.isSuccess;
  }

  @override
  set isSuccess(bool value) {
    _$isSuccessAtom.reportWrite(value, super.isSuccess, () {
      super.isSuccess = value;
    });
  }

  late final _$submitInquiryAsyncAction =
      AsyncAction('_InquiryStore.submitInquiry', context: context);

  @override
  Future<void> submitInquiry({
    required String clientName,
    required String email,
    required String? phoneNumber,
    required String projectType,
    required String? message,
    required String? budgetRange,
    required String? timeline,
  }) {
    return _$submitInquiryAsyncAction.run(() => super.submitInquiry(
          clientName: clientName,
          email: email,
          phoneNumber: phoneNumber,
          projectType: projectType,
          message: message,
          budgetRange: budgetRange,
          timeline: timeline,
        ));
  }

  late final _$_InquiryStoreActionController =
      ActionController(name: '_InquiryStore', context: context);

  @override
  void clearError() {
    final _$actionInfo = _$_InquiryStoreActionController.startAction(
        name: '_InquiryStore.clearError');
    try {
      return super.clearError();
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
  String toString() {
    return '''
isLoading: ${isLoading},
error: ${error},
isSuccess: ${isSuccess}
    ''';
  }
}
