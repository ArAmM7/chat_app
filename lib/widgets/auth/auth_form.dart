import 'dart:io';

import 'package:flutter/material.dart';

import 'package:chat_app/widgets/pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(
          String email, String username, String password, File userImageFile, bool isLogin)
      submitAuthForm;
  final bool isLoading;

  const AuthForm(this.submitAuthForm, this.isLoading, {Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _username = '';
  var _userPassword = '';
  var _userImageFile = File('');

  @override
  Widget build(BuildContext context) {
    // password with minimum 8 length, uppercase, lowercase, numbers and symbols
    // const passwordPattern =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    const passwordPattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    const emailPattern =
        '^(?:[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+)*|"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])\$';
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin) UserImagePicker(_pickedImage),
                TextFormField(
                  key: const ValueKey('email'),
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  enableSuggestions: false,
                  validator: (value) {
                    if (value!.isEmpty || !RegExp(emailPattern).hasMatch(value)) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Email address'),
                  onSaved: (newValue) {
                    _userEmail = newValue!;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    autocorrect: true,
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                    validator: (value) {
                      if (value!.length < 4) {
                        return 'Please enter at least 4 characters';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: 'Username'),
                    onSaved: (newValue) {
                      _username = newValue!;
                    },
                  ),
                TextFormField(
                  key: const ValueKey('password'),
                  validator: (value) {
                    if (value!.isEmpty || !RegExp(passwordPattern).hasMatch(value)) {
                      return 'weak password, It must be at least 8 characters long and contain uppercase characters, lowercase characters and numbers';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onSaved: (newValue) {
                    _userPassword = newValue!;
                  },
                ),
                const SizedBox(height: 12),
                if (widget.isLoading) const CircularProgressIndicator(),
                if (!widget.isLoading)
                  ElevatedButton(
                    // style: ButtonStyle(
                    //     backgroundColor:
                    //         MaterialStatePropertyAll(Theme.of(context).colorScheme.secondary)),
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'Login' : 'Sign Up'),
                  ),
                if (!widget.isLoading)
                  TextButton(
                    onPressed: () => setState(() => _isLogin = !_isLogin),
                    child: Text(_isLogin ? 'Create new account' : 'Already have an account?'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile.path.isEmpty && !_isLogin) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Proifle picture'),
          content: const Text('Please select a picture to put as your profile picture'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitAuthForm(_userEmail, _username, _userPassword, _userImageFile, _isLogin);
    }
  }

  void _pickedImage(File image) {
    _userImageFile = image;
  }
}
