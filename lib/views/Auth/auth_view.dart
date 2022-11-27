import 'dart:io';

import 'package:chat_app/views/Auth/stores/login_loading.dart';
import 'package:chat_app/views/Auth/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  var _userEmail = '';
  var _username = '';
  var _userPassword = '';
  var _userImageFile = File('');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // password with minimum 8 length, uppercase, lowercase, numbers and symbols
  // const passwordPattern =
  //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  static const passwordPattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
  static const emailPattern =
      '^(?:[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+)*|"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])\$';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Observer(builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!GetIt.I<LoginLoading>().isLogin) UserImagePicker(_pickedImage),
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
                    if (!GetIt.I<LoginLoading>().isLogin)
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
                    if (GetIt.I<LoginLoading>().isLoading) const CircularProgressIndicator(),
                    if (!GetIt.I<LoginLoading>().isLoading)
                      ElevatedButton(
                        // style: ButtonStyle(
                        //     backgroundColor:
                        //         MaterialStatePropertyAll(Theme.of(context).colorScheme.secondary)),
                        onPressed: () async {
                          final isValid = _formKey.currentState!.validate();
                          FocusScope.of(context).unfocus();
                          if (_userImageFile.path.isEmpty && !GetIt.I<LoginLoading>().isLogin) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Proifle picture'),
                                content: const Text(
                                    'Please select a picture to put as your profile picture'),
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

                            UserCredential cred;
                            try {
                              GetIt.I<LoginLoading>().setLoading(true);
                              if (GetIt.I<LoginLoading>().isLogin) {
                                cred = await _auth.signInWithEmailAndPassword(
                                    email: _userEmail, password: _userPassword);
                                GetIt.I<LoginLoading>().setLoading(false);
                              } else {
                                cred = await _auth.createUserWithEmailAndPassword(
                                    email: _userEmail, password: _userPassword);

                                final ref = FirebaseStorage.instance
                                    .ref()
                                    .child('user_images')
                                    .child('${cred.user!.uid}.jpg');
                                await ref.putFile(_userImageFile);
                                final url = await ref.getDownloadURL();
                                await _firestore.collection('users').doc(cred.user!.uid).set({
                                  'username': _username,
                                  'email': _userEmail,
                                  'image_url': url,
                                });
                                GetIt.I<LoginLoading>().setLoading(false);
                              }
                            } on FirebaseAuthException catch (e) {
                              GetIt.I<LoginLoading>().setLoading(false);
                              var message = 'Authentication failed';
                              if (e.message != null) {
                                message = e.message!;
                              }
                              print(e.toString());
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(message)));
                            } catch (e) {
                              print(e);
                              GetIt.I<LoginLoading>().setLoading(false);
                              rethrow;
                            }
                          }
                        },
                        child: Text(GetIt.I<LoginLoading>().isLogin ? 'Login' : 'Sign Up'),
                      ),
                    if (!GetIt.I<LoginLoading>().isLoading)
                      TextButton(
                        onPressed: () => GetIt.I<LoginLoading>().toggleLogin(),
                        child: Text(GetIt.I<LoginLoading>().isLogin
                            ? 'Create new account'
                            : 'Already have an account?'),
                      ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void _pickedImage(File image) {
    _userImageFile = image;
  }
}
