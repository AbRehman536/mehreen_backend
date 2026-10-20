import 'package:flutter/material.dart';
import 'package:mehreen_backend/models/userModel.dart';

class UserProvider extends ChangeNotifier {

  UserModel _userModel = UserModel();

  ///set User
 void setUser(UserModel model){
   _userModel = model;
   notifyListeners();
 }

 ///get User
 UserModel getUser() => _userModel;
}