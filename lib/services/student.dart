import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mehreen_backend/models/student.dart';

class StudentService{

  String studentCollection = "Students";
  ///Create Student
  Future createStudent(StudentModel model)async{
    DocumentReference docRef =
    await FirebaseFirestore.instance
    .collection(studentCollection)
    .doc();
    return await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }
  ///Update Student
  Future updateStudent(StudentModel model)async{
    return await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc(model.docId)
        .update({"name" : model.name, "age": model.age, "city" : model.city,});
  }
  ///Delete Student
  Future deleteStudent(StudentModel model)async{
    return await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc(model.docId)
        .delete();
  }
  ///Mark Students
  Future markStudent(StudentModel model)async{
    return await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc(model.docId)
        .update({"isPassed" : model.isPassed});
  }
  ///Get All Students
  Stream<List<StudentModel>> getAllStudents(){
    return FirebaseFirestore.instance
        .collection(studentCollection)
        .snapshots()
        .map((studentList)=> studentList.docs
        .map((studentJson)=> StudentModel.fromJson(studentJson.data()))
        .toList()
    );
  }
  ///Get Passed Students
  Stream<List<StudentModel>> getPassedStudents(){
    return FirebaseFirestore.instance
        .collection(studentCollection)
        .where("isPassed" ,isEqualTo: true)
        .snapshots()
        .map((studentList)=> studentList.docs
        .map((studentJson)=> StudentModel.fromJson(studentJson.data()))
        .toList()
    );
  }
  ///Get Failed Students
  Stream<List<StudentModel>> getFailedStudents(){
    return FirebaseFirestore.instance
        .collection(studentCollection)
        .where("isPassed", isEqualTo: false)
        .snapshots()
        .map((studentList)=> studentList.docs
        .map((studentJson)=> StudentModel.fromJson(studentJson.data()))
        .toList()
    );
  }
}