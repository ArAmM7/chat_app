// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picked_image.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PickedImage on _PickedImage, Store {
  late final _$pickedImageAtom =
      Atom(name: '_PickedImage.pickedImage', context: context);

  @override
  File get pickedImage {
    _$pickedImageAtom.reportRead();
    return super.pickedImage;
  }

  @override
  set pickedImage(File value) {
    _$pickedImageAtom.reportWrite(value, super.pickedImage, () {
      super.pickedImage = value;
    });
  }

  late final _$_PickedImageActionController =
      ActionController(name: '_PickedImage', context: context);

  @override
  void chooseImage(File img) {
    final _$actionInfo = _$_PickedImageActionController.startAction(
        name: '_PickedImage.chooseImage');
    try {
      return super.chooseImage(img);
    } finally {
      _$_PickedImageActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pickedImage: ${pickedImage}
    ''';
  }
}
