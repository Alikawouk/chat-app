import 'dart:developer';
import 'dart:io';
import 'package:chat/widget/user_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  var _enteredUsername = '';
  var _enteredEmail = '';
  var _enteredPassword = '';
  File? _selectedImage;
  bool _isUploading = false;
  bool _isLogin = true;

  void _submit() async {
    final valid = _fromKey.currentState!.validate();
    if (!valid || !_isLogin && _selectedImage == null) {
      return;
    }
    try {
      setState(() {
        _isUploading = true;
      });
      if (_isLogin) {
        final UserCredential userCredential =
            await _firebase.signInWithEmailAndPassword(
                email: _enteredEmail, password: _enteredPassword);
      } else {
        final UserCredential userCredential =
            await _firebase.createUserWithEmailAndPassword(
                email: _enteredEmail, password: _enteredPassword);

        final Reference storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredential.user!.uid}.jpg');

        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef
            .getDownloadURL(); //link of photo after it is on the storage

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': _enteredUsername,
          'email': _enteredEmail,
          'image_url': imageUrl
        });
      }
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).clearSnackBars();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? 'Auth failed')));
      setState(() {
        _isUploading = false;
      });
    }

    if (_fromKey.currentState == null) {
      return;
    } else {
      _fromKey.currentState!.save();
    }
    log(_enteredEmail);
    log(_enteredPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 30, bottom: 30, right: 20, left: 20),
                width: 200,
                child: Image.asset('images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _fromKey,
                    child: Column(
                      children: [
                        if (!_isLogin)
                          UserImagePicker(
                            onPickImage: (File pickedImage) {
                              _selectedImage = pickedImage;
                            },
                          ),
                        if (!_isLogin)
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Username'),
                            onSaved: (value) {
                              setState(() {
                                _enteredUsername = value as String;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.trim().length < 4) {
                                return 'please enter at least 4 charchters ';
                              } else {
                                return null;
                              }
                            },
                          ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Email Adress'),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          onSaved: (value) {
                            setState(() {
                              _enteredEmail = value as String;
                            });
                          },
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'please enter a valid email adress';
                            } else {
                              return null;
                            }
                          },
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          onSaved: (value) {
                            setState(() {
                              _enteredPassword = value!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'password must be of 6 charcters at least';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        if (_isUploading) const CircularProgressIndicator(),
                        if (!_isUploading)
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              onPressed: _submit,
                              child: Text(
                                _isLogin ? 'Login' : 'SignUp',
                              ),
                            ),
                          ),
                        if (!_isUploading)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(
                              _isLogin
                                  ? 'Create an Account'
                                  : 'I already have an account',
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
