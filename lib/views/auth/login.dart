import 'package:flutter/material.dart';
import 'package:mehreen_backend/services/auth.dart';
import 'package:mehreen_backend/views/auth/register.dart';
import 'package:mehreen_backend/views/auth/reset_password.dart';
import 'package:mehreen_backend/views/students/get_all_students.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
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
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              await AuthService().loginUser(
                  email: emailController.text,
                  password: passwordController.text)
                  .then((value){
                    if(value.emailVerified == true){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllStudents()));
                    }
                    else{
                      isLoading = false;
                      setState(() {});
                      showDialog(
                        context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Kindly Verify Your Email"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("Okay"))
                          ],
                        );
                      },);
                    }

              });
            }catch(e){
              isLoading = false;
              setState(() {});
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Login")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen()));
          }, child: Text("Register Screen")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPassword()));
          }, child: Text("Reset Password")),
        ],
      ),
    );
  }
}
