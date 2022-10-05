import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagrPickFn;

  const UserImagePicker(this.imagrPickFn, {Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage = File('');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 42,
          backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.5),
          backgroundImage: _pickedImage.path.isNotEmpty
              ? Image.file(_pickedImage).image
              : Image.asset('assets/img/avatar.png').image,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.portrait),
          label: const Text('Add Image'),
        ),
      ],
    );
  }

  void _pickImage() async {
    final img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 256,
      maxHeight: 256,
    );
    if (img == null) {
      return;
    }
    setState(() => _pickedImage = File(img.path));
    widget.imagrPickFn(_pickedImage);
  }
}
