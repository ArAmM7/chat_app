// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_composing.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MessageComposing on _MessageComposing, Store {
  late final _$enteredMessageAtom =
      Atom(name: '_MessageComposing.enteredMessage', context: context);

  @override
  String get enteredMessage {
    _$enteredMessageAtom.reportRead();
    return super.enteredMessage;
  }

  @override
  set enteredMessage(String value) {
    _$enteredMessageAtom.reportWrite(value, super.enteredMessage, () {
      super.enteredMessage = value;
    });
  }

  late final _$controllerAtom =
      Atom(name: '_MessageComposing.controller', context: context);

  @override
  TextEditingController get controller {
    _$controllerAtom.reportRead();
    return super.controller;
  }

  @override
  set controller(TextEditingController value) {
    _$controllerAtom.reportWrite(value, super.controller, () {
      super.controller = value;
    });
  }

  late final _$_MessageComposingActionController =
      ActionController(name: '_MessageComposing', context: context);

  @override
  void updateMessage(String val) {
    final _$actionInfo = _$_MessageComposingActionController.startAction(
        name: '_MessageComposing.updateMessage');
    try {
      return super.updateMessage(val);
    } finally {
      _$_MessageComposingActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearMessage() {
    final _$actionInfo = _$_MessageComposingActionController.startAction(
        name: '_MessageComposing.clearMessage');
    try {
      return super.clearMessage();
    } finally {
      _$_MessageComposingActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
enteredMessage: ${enteredMessage},
controller: ${controller}
    ''';
  }
}
