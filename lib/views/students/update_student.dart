import 'package:flutter/material.dart';
import 'package:mehreen_backend/models/student.dart';
import 'package:mehreen_backend/services/student.dart';

class UpdateStudent extends StatefulWidget {
  final StudentModel model;
  const UpdateStudent({super.key, required this.model});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
    super.initState();
    nameController = TextEditingController(
      text: widget.model.name.toString()
    );
    ageController = TextEditingController(
      text: widget.model.age.toString()
    );
    cityController = TextEditingController(
      text: widget.model.city.toString()
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Student"),
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
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              await StudentService().updateStudent(
                  StudentModel(
                    docId: widget.model.docId,
                      name: nameController.text.toString(),
                      age: int.parse(ageController.text),
                      city: cityController.text.toString(),
                  )
              ).then((val){
                isLoading = false;
                setState(() {});
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Student Update Successfully"),
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
          }, child: Text("Update Student"))
        ],
      ),
    );
  }
}
