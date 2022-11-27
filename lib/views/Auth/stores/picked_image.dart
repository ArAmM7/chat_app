import 'dart:io';

import 'package:mobx/mobx.dart';

part 'picked_image.g.dart';

class PickedImage = _PickedImage with _$PickedImage;

abstract class _PickedImage with Store {
  @observable
  File pickedImage = File('');

  @action
  void chooseImage(File img) => pickedImage = img;
}
