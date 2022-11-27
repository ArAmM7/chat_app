// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_loading.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginLoading on _LoginLoading, Store {
  late final _$isLoginAtom =
      Atom(name: '_LoginLoading.isLogin', context: context);

  @override
  bool get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(bool value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_LoginLoading.isLoading', context: context);

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

  late final _$_LoginLoadingActionController =
      ActionController(name: '_LoginLoading', context: context);

  @override
  void toggleLogin() {
    final _$actionInfo = _$_LoginLoadingActionController.startAction(
        name: '_LoginLoading.toggleLogin');
    try {
      return super.toggleLogin();
    } finally {
      _$_LoginLoadingActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool val) {
    final _$actionInfo = _$_LoginLoadingActionController.startAction(
        name: '_LoginLoading.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$_LoginLoadingActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLogin: ${isLogin},
isLoading: ${isLoading}
    ''';
  }
}
