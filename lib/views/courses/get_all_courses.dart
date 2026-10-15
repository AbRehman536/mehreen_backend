import 'package:flutter/material.dart';
import 'package:mehreen_backend/models/Course.dart';
import 'package:mehreen_backend/models/student.dart';
import 'package:mehreen_backend/services/course.dart';
import 'package:mehreen_backend/services/student.dart';
import 'package:mehreen_backend/views/courses/create_update_cpurse.dart';
import 'package:mehreen_backend/views/students/create_student.dart';
import 'package:mehreen_backend/views/students/get_failed.dart';
import 'package:mehreen_backend/views/students/get_passed.dart';
import 'package:mehreen_backend/views/students/get_saved_students.dart';
import 'package:mehreen_backend/views/students/update_student.dart';
import 'package:provider/provider.dart';

class GetAllCourses extends StatelessWidget {
  const GetAllCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Courses"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateUpdateCourse(model: CourseModel(), isUpdatedMode: false)));
        },child: Icon(Icons.add),),
      body: StreamProvider.value(
        value: CourseService().getAllCourses(),
        initialData: [CourseModel()],
        builder: (context, child){
          List<CourseModel> courseList = context.watch<List<CourseModel>>();
          return ListView.builder(
            itemCount: courseList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: .circular(12),
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black,
                          width: 0.4
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            shape: .circle
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${index + 1}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white
                                            ),),
                                        )),
                                    SizedBox(width: 10,),
                                    Text(courseList[index].courseName.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                               IconButton(onPressed: ()async{
                                  try{
                                    await CourseService().deleteCourse(
                                        courseList[index].docId.toString()
                                    );
                                  }catch(e){
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(content: Text(e.toString())));
                                  }
                                }, icon: Icon(Icons.delete,color: Colors.red,)),
                                IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateUpdateCourse(model: courseList[index], isUpdatedMode: true,)));
                                }, icon: Icon(Icons.edit, color: Colors.blue,))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },);
        },
      ),
    );
  }
}
