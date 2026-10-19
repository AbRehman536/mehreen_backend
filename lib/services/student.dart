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
  Future deleteStudent(String studentID)async{
    return await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc(studentID)
        .delete();
  }
  ///Mark Students
  Future markStudent(String studentID, bool isPassed)async{
    return await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc(studentID)
        .update({"isPassed" : isPassed});
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
  ///Get All Saved Students
  Stream<List<StudentModel>> getAllSavedStudents(String userID){
    return FirebaseFirestore.instance
        .collection(studentCollection)
        .where("saved" , arrayContains: userID)
        .snapshots()
        .map((studentList)=> studentList.docs
        .map((studentJson)=> StudentModel.fromJson(studentJson.data()))
        .toList()
    );
  }
  ///add to Saved
  Future addToSaved({
    required String userID, required String studentID})
  async{
    return await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc(studentID)
        .update({"saved": FieldValue.arrayUnion([userID])});
  }
  ///remove From Saved
  Future removeFromSaved({
    required String userID, required String studentID})
  async{
    return await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc(studentID)
        .update({"saved": FieldValue.arrayRemove([userID])});
  }
  ///Get Student by Course ID
  Stream<List<StudentModel>> getStudentByCourseID(String courseID){
    return FirebaseFirestore.instance
        .collection(studentCollection)
        .where("courseID", isEqualTo: courseID)
        .snapshots()
        .map((studentList)=> studentList.docs
        .map((studentJson)=> StudentModel.fromJson(studentJson.data()))
        .toList()
    );
  }
}