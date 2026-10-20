import 'package:flutter/material.dart';
import 'package:mehreen_backend/provider/user.dart';
import 'package:provider/provider.dart';

class GetProfile extends StatelessWidget {
  const GetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Name: ${userProvider.getUser().userName.toString()}"),
            Text("Email: ${userProvider.getUser().email.toString()}"),
            Text("Phone: ${userProvider.getUser().phone.toString()}"),
            Text("Address: ${userProvider.getUser().address.toString()}"),
          ],
        ),
      ),
    );
  }
}
