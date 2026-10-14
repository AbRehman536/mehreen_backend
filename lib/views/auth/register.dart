import 'package:flutter/material.dart';
import 'package:mehreen_backend/services/auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                  await AuthService().registerUser(
                      email: emailController.text,
                      password: passwordController.text)
                      .then((value){
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
