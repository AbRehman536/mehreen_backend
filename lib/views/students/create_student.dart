import 'package:flutter/material.dart';
import 'package:mehreen_backend/models/Course.dart';
import 'package:mehreen_backend/models/student.dart';
import 'package:mehreen_backend/services/course.dart';
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
  bool isLoading = false;

  List<CourseModel> courseList = [];
  CourseModel? selectedCourse;
  @override
  void initState(){
    super.initState();
    CourseService().getCourses()
    .then((value){
      setState(() {
        courseList = value;
      });
    });
  }
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
          DropdownButtonFormField(
            hint: Text("Select Course"),
              value: selectedCourse,
              items: courseList.map((course){
                return DropdownMenuItem(
                  value: course,
                    child: Text(course.courseName.toString()));
              }).toList(),
              onChanged: (val){
              setState(() {
                selectedCourse = val;
              });
              }),
          SizedBox(height: 10,),
          isLoading ? Center(child: CircularProgressIndicator(),)
          :ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              await StudentService().createStudent(
                  StudentModel(
                    courseID: selectedCourse!.docId.toString(),
                      name: nameController.text.toString(),
                      age: int.parse(ageController.text),
                      city: cityController.text.toString(),
                      isPassed: false,
                      createdAt: DateTime.now().millisecondsSinceEpoch
                  )
              ).then((val){
                isLoading = false;
                setState(() {});
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Student Create Successfully"),
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
          }, child: Text("Create Student"))
        ],
      ),
    );
  }
}
