import 'package:flutter/material.dart';
import 'package:mehreen_backend/models/student.dart';
import 'package:mehreen_backend/services/student.dart';
import 'package:mehreen_backend/views/students/create_student.dart';
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
              return Card(
                child: ListTile(
                  leading: Icon(Icons.school),
                  title: Text(studentList[index].name.toString()),
                  subtitle: Text(studentList[index].age.toString()),
                  trailing: Text(studentList[index].city.toString()),
                ),
              );
            },);
          },
      ),
    );
  }
}
