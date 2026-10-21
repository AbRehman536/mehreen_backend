import 'package:flutter/material.dart';
import 'package:mehreen_backend/models/userModel.dart';

class UserProvider extends ChangeNotifier {

  UserModel userModel = UserModel();

  ///set User
 void setUser(UserModel model){
   userModel = model;
   notifyListeners();
 }

 ///get User
 UserModel getUser() => userModel;
}