// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

mixin _$AboutStore on _AboutStore, Store {
  Computed<bool>? _$hasInfoComputed;

  @override
  bool get hasInfo =>
      (_$hasInfoComputed ??= Computed<bool>(() => super.hasInfo,
              name: '_AboutStore.hasInfo'))
          .value;

  late final _$agencyInfoAtom =
      Atom(name: '_AboutStore.agencyInfo', context: context);

  @override
  AgencyInfo? get agencyInfo {
    _$agencyInfoAtom.reportRead();
    return super.agencyInfo;
  }

  @override
  set agencyInfo(AgencyInfo? value) {
    _$agencyInfoAtom.reportWrite(value, super.agencyInfo, () {
      super.agencyInfo = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AboutStore.isLoading', context: context);

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
      Atom(name: '_AboutStore.error', context: context);

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

  late final _$fetchAgencyInfoAsyncAction =
      AsyncAction('_AboutStore.fetchAgencyInfo', context: context);

  @override
  Future<void> fetchAgencyInfo() {
    return _$fetchAgencyInfoAsyncAction.run(() => super.fetchAgencyInfo());
  }

  late final _$_AboutStoreActionController =
      ActionController(name: '_AboutStore', context: context);

  @override
  void clearError() {
    final _$actionInfo = _$_AboutStoreActionController.startAction(
        name: '_AboutStore.clearError');
    try {
      return super.clearError();
    } finally {
      _$_AboutStoreActionController.endAction(_$actionInfo);
    }
  }
}
