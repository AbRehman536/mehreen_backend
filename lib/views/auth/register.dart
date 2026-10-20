import 'package:flutter/material.dart';
import 'package:mehreen_backend/models/userModel.dart';
import 'package:mehreen_backend/services/auth.dart';
import 'package:mehreen_backend/services/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hint: Text("Enter your username"),
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hint: Text("Enter your email"),
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hint: Text("Enter your password"),
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
              hint: Text("Enter your phone"),
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              hint: Text("Enter your address"),
            ),
          ),
          SizedBox(height: 10,),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  isLoading = true;
                  setState(() {});
                  await AuthService().registerUser(
                      email: emailController.text,
                      password: passwordController.text)
                      .then((value)async{
                        await UserService().createUser(
                          UserModel(
                            docId: value.uid.toString(),
                            userName: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            address: addressController.text,
                            createdAt: DateTime.now().millisecondsSinceEpoch
                          )
                        )
                        .then((val){
                          isLoading = false;
                          setState(() {});
                          showDialog(
                            context: context, builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text("Register Successfully"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }, child: Text("Okay"))
                              ],
                            );
                          },);
                        });
                  });
                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
                }
          }, child: Text("Register"))
        ],
      ),
    );
  }
}
