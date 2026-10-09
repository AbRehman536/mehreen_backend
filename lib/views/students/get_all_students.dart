import 'package:flutter/material.dart';
import 'package:mehreen_backend/models/student.dart';
import 'package:mehreen_backend/services/student.dart';
import 'package:mehreen_backend/views/students/create_student.dart';
import 'package:mehreen_backend/views/students/update_student.dart';
import 'package:provider/provider.dart';

class GetAllStudents extends StatelessWidget {
  const GetAllStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Students"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateStudent()));
        },child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: StudentService().getAllStudents(),
          initialData: [StudentModel()],
          builder: (context, child){
            List<StudentModel> studentList = context.watch<List<StudentModel>>();
            return ListView.builder(
              itemCount: studentList.length,
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
                                    Text(studentList[index].name.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Age: ${studentList[index].age.toString()}"),
                                    SizedBox(width: 10,),
                                    Text("City: ${studentList[index].city.toString()}"),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(onPressed: ()async{
                                  try{
                                    await StudentService().deleteStudent(
                                      studentList[index].docId.toString()
                                    );
                                  }catch(e){
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(content: Text(e.toString())));
                                  }
                                }, icon: Icon(Icons.delete,color: Colors.red,)),
                                IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateStudent(model: studentList[index])));
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
