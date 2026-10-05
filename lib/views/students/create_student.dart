import 'package:flutter/material.dart';
import 'package:mehreen_backend/models/student.dart';
import 'package:mehreen_backend/services/student.dart';

class CreateStudent extends StatefulWidget {
  const CreateStudent({super.key});

  @override
  State<CreateStudent> createState() => _CreateStudentState();
}

class _CreateStudentState extends State<CreateStudent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Student"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hint: Text("Enter Name"),
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: ageController,
            decoration: InputDecoration(
              hint: Text("Enter Age"),
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: cityController,
            decoration: InputDecoration(
              hint: Text("Enter City"),
            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: ()async{
            try{
              await StudentService().createStudent(
                  StudentModel(
                      name: nameController.text.toString(),
                      age: int.parse(ageController.text),
                      city: cityController.text.toString(),
                      isPassed: false,
                      createdAt: DateTime.now().millisecondsSinceEpoch
                  )
              );
            }catch(e){
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Create Student"))
        ],
      ),
    );
  }
}
