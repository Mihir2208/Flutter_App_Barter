import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider with ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  String email;
  String username;
  String error = '';
  File prodImage;
  String pickError = '';
  bool isImgAvailable = false;

  Future<UserCredential> userSignUp(email, password) async {
    this.email = email;
    notifyListeners();
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (err) {
      if (err.code == 'weak-password') {
        this.error = 'The password provided is too weak.';
        print('hi1');
        notifyListeners();
      } else if (err.code == 'email-already-in-use') {
        this.error = 'The account already exists for that email.';
        print('hi2');
        notifyListeners();
      }
    } catch (err) {
      print(err);
    }
    print('dimag kharab');
    print(userCredential);
    return userCredential;
  }

  Future<void> saveUserToDb({
    String username,
    String password,
    String prodName,
    String prodDeatails,
  }) {
    User user = FirebaseAuth.instance.currentUser;
    DocumentReference _users =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    _users.set({
      'uid': user.uid,
      'email': this.email,
      'username': username,
      'password': password,
    });
  
  }

  Future<UserCredential> userSignIn(email, password) async {
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (err) {
      if (err.code == 'weak-password') {
        this.error = 'The password provided is too weak.';
        notifyListeners();
      } else if (err.code == 'email-already-in-use') {
        this.error = 'The account already exists for that email.';
        notifyListeners();
      }
    } catch (err) {
      print(err);
    }
    return userCredential;
  }

  final picker = ImagePicker();
  Future<File> getImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      this.prodImage = File(pickedImage.path);
      notifyListeners();
    } else {
      this.pickError = 'No image selected';
      print('No image selected');
    }
    return this.prodImage;
  }

  Future<void> updateUser(Map<String, dynamic> values) async {
    String id = values['id'];
    await _firestore
        .collection('users')
        .doc(id)
        .collection('products')
        .add(values);
    notifyListeners();
  }
}
