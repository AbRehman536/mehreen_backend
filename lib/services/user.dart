import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/userModel.dart';

class UserService{

  String UserCollection = "Users";
  ///Create User
  Future createUser(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(UserCollection)
        .doc(model.docId)
        .set(model.toJson());
  }
  ///Update User
  Future updateUser(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(UserCollection)
        .doc(model.docId)
        .update({"userName" : model.userName,"phone" : model.phone,
    "address" : model.address});
  }
  ///Delete User
  Future deleteUser(String userID)async{
    return await FirebaseFirestore.instance
        .collection(UserCollection)
        .doc(userID)
        .delete();
  }
  ///Get User By ID
  Future<UserModel> getUserByID(String userID){
    return FirebaseFirestore.instance
        .collection(UserCollection)
        .doc(userID)
        .get()
        .then((userJson) => UserModel.fromJson(userJson.data()!));
  }
}