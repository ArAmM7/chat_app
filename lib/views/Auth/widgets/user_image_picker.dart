import 'dart:io';

import 'package:chat_app/views/Auth/stores/picked_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatelessWidget {
  const UserImagePicker(this.imagePickFn, {Key? key}) : super(key: key);
  final void Function(File pickedImage) imagePickFn;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(
          builder: (context) => CircleAvatar(
            radius: 42,
            backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.5),
            backgroundImage: GetIt.I<PickedImage>().pickedImage.path.isNotEmpty
                ? Image.file(GetIt.I<PickedImage>().pickedImage).image
                : Image.asset('assets/img/avatar.png').image,
          ),
        ),
        TextButton.icon(
          onPressed: () async {
            final img = await ImagePicker().pickImage(
              source: ImageSource.gallery,
              imageQuality: 50,
              maxWidth: 256,
              maxHeight: 256,
            );
            if (img == null) {
              return;
            }
            GetIt.I<PickedImage>().chooseImage(File(img.path));
            imagePickFn(GetIt.I<PickedImage>().pickedImage);
          },
          icon: const Icon(Icons.portrait),
          label: const Text('Add Image'),
        ),
      ],
    );
  }
}
