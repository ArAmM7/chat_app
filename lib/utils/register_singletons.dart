import 'package:chat_app/stores/firebase_init.dart';
import 'package:chat_app/views/Auth/stores/login_loading.dart';
import 'package:chat_app/views/Auth/stores/picked_image.dart';
import 'package:chat_app/views/Chat/stores/message_composing.dart';
import 'package:get_it/get_it.dart';

class RegisterSingletons{
  static void init(){
    GetIt.I.registerSingleton<FirebaseInit>(FirebaseInit());
    GetIt.I.registerSingleton<PickedImage>(PickedImage());
    GetIt.I.registerSingleton<LoginLoading>(LoginLoading());
    GetIt.I.registerSingleton<MessageComposing>(MessageComposing());
  }
}