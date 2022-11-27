// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_init.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FirebaseInit on _FirebaseInit, Store {
  late final _$isLoadedAtom =
      Atom(name: '_FirebaseInit.isLoaded', context: context);

  @override
  bool get isLoaded {
    _$isLoadedAtom.reportRead();
    return super.isLoaded;
  }

  @override
  set isLoaded(bool value) {
    _$isLoadedAtom.reportWrite(value, super.isLoaded, () {
      super.isLoaded = value;
    });
  }

  late final _$isLoggedInAtom =
      Atom(name: '_FirebaseInit.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$_initNotificationsAsyncAction =
      AsyncAction('_FirebaseInit._initNotifications', context: context);

  @override
  Future<void> _initNotifications() {
    return _$_initNotificationsAsyncAction
        .run(() => super._initNotifications());
  }

  @override
  String toString() {
    return '''
isLoaded: ${isLoaded},
isLoggedIn: ${isLoggedIn}
    ''';
  }
}
