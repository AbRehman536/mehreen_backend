import 'package:flutter/material.dart';
import 'package:mehreen_backend/models/userModel.dart';
import 'package:mehreen_backend/provider/user.dart';
import 'package:mehreen_backend/services/user.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
    super.initState();
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    final user = userProvider.userModel;
    nameController= TextEditingController(text: user.userName.toString());
    phoneController= TextEditingController(text: user.phone.toString());
    addressController= TextEditingController(text: user.address.toString());
  }
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hint: Text("Enter your name")
            ),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
              hint: Text("Enter your phone")
            ),
          ),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              hint: Text("Enter your address")
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  isLoading = true;
                  setState(() {});
                  final currentUser  = userProvider.userModel;
                  if(currentUser == null || currentUser.docId == null){
                    throw "User not Found";
                  }
                  UserModel updatedModel =
                  UserModel(
                    docId: currentUser.docId.toString(),
                    email: currentUser.email,
                    userName: nameController.text,
                    phone: phoneController.text,
                    address: addressController.text,
                  );
                  await UserService().updateUser(updatedModel);
                  UserModel freshUser = await UserService().getUserByID(currentUser.docId.toString());
                  userProvider.setUser(freshUser);
                }catch(e){

                }
          }, child: Text("Update Profile"))
        ],
      ),
    );
  }
}
