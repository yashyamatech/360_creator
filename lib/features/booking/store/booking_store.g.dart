// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookingStore on _BookingStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_BookingStore.isLoading', context: context);

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

  late final _$isSuccessAtom =
      Atom(name: '_BookingStore.isSuccess', context: context);

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

  late final _$selectedVideoIdAtom =
      Atom(name: '_BookingStore.selectedVideoId', context: context);

  @override
  String? get selectedVideoId {
    _$selectedVideoIdAtom.reportRead();
    return super.selectedVideoId;
  }

  @override
  set selectedVideoId(String? value) {
    _$selectedVideoIdAtom.reportWrite(value, super.selectedVideoId, () {
      super.selectedVideoId = value;
    });
  }

  late final _$submitBookingAsyncAction =
      AsyncAction('_BookingStore.submitBooking', context: context);

  @override
  Future<void> submitBooking({
    required String clientName,
    required String email,
    required String? phoneNumber,
    required String? projectRequirements,
    required String? budget,
    required String? timeline,
  }) {
    return _$submitBookingAsyncAction.run(() => super.submitBooking(
          clientName: clientName,
          email: email,
          phoneNumber: phoneNumber,
          projectRequirements: projectRequirements,
          budget: budget,
          timeline: timeline,
        ));
  }

  late final _$_BookingStoreActionController =
      ActionController(name: '_BookingStore', context: context);

  @override
  void selectVideo(String videoId) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.selectVideo');
    try {
      return super.selectVideo(videoId);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearError() {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.clearError');
    try {
      return super.clearError();
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
  String toString() {
    return '''
isLoading: ${isLoading},
error: ${error},
isSuccess: ${isSuccess},
selectedVideoId: ${selectedVideoId}
    ''';
  }
}
