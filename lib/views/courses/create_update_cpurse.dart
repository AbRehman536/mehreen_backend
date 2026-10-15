import 'package:flutter/material.dart';
import 'package:mehreen_backend/models/Course.dart';
import 'package:mehreen_backend/services/course.dart';

class CreateUpdateCourse extends StatefulWidget {
  final CourseModel model;
  final bool isUpdatedMode;
  const CreateUpdateCourse({super.key, required this.model, required this.isUpdatedMode});

  @override
  State<CreateUpdateCourse> createState() => _CreateUpdateCourseState();
}

class _CreateUpdateCourseState extends State<CreateUpdateCourse> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
    super.initState();
    if(widget.isUpdatedMode == true)
    nameController = TextEditingController(
        text: widget.model.courseName.toString()
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdatedMode ? "Update Course" : "Create Course"),
        backgroundColor: widget.isUpdatedMode ? Colors.blue : Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hint: Text("Enter Course Name"),
            ),
          ),
          SizedBox(height: 10,),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  if(widget.isUpdatedMode == true){
                    await CourseService().updateCourse(
                      CourseModel(
                        docId: widget.model.docId.toString(),
                        courseName: nameController.text,
                      )
                    ).then((value){
                      showDialog(
                          context: context, builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text("Update Successfully"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }, child: Text("Okay"))
                              ],
                            );
                      },);
                    });
                  }
                  else{
                    await CourseService().createCourse(
                        CourseModel(
                          courseName: nameController.text,
                          createdAt: DateTime.now().millisecondsSinceEpoch
                        )
                    ).then((value){
                      showDialog(
                        context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Create Successfully"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, child: Text("Okay"))
                          ],
                        );
                      },);
                    });
                  }
                }catch(e){
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
          },
              child: Text(
                widget.isUpdatedMode == true ?
                    "Update Course" : "Create Course"
              ))
        ],
      ),
    );
  }
}
