import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'message_composing.g.dart';

class MessageComposing = _MessageComposing with _$MessageComposing;

abstract class _MessageComposing with Store {
  @observable
  String enteredMessage = '';

  @observable
  TextEditingController controller = TextEditingController();

  @action
  void updateMessage(String val) => enteredMessage = val;

  @action
  void clearMessage() => controller.clear();

}