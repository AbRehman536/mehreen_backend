import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mehreen_backend/models/Course.dart';

class CourseService{

  String CourseCollection = "Courses";
  ///Create Course
  Future createCourse(CourseModel model)async{
    DocumentReference docRef =
    await FirebaseFirestore.instance
        .collection(CourseCollection)
        .doc();
    return await FirebaseFirestore.instance
        .collection(CourseCollection)
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }
  ///Update Course
  Future updateCourse(CourseModel model)async{
    return await FirebaseFirestore.instance
        .collection(CourseCollection)
        .doc(model.docId)
        .update({"courseName" : model.courseName,});
  }
  ///Delete Course
  Future deleteCourse(String courseID)async{
    return await FirebaseFirestore.instance
        .collection(CourseCollection)
        .doc(courseID)
        .delete();
  }
  ///Get All Courses
  Stream<List<CourseModel>> getAllCourses(){
    return FirebaseFirestore.instance
        .collection(CourseCollection)
        .orderBy("createdAt" , descending: true)
        .snapshots()
        .map((CourseList)=> CourseList.docs
        .map((CourseJson)=> CourseModel.fromJson(CourseJson.data()))
        .toList()
    );
  }
  ///Get Courses
  Future<List<CourseModel>> getCourses(){
    return FirebaseFirestore.instance
        .collection(CourseCollection)
        .orderBy("createdAt" , descending: true)
        .get()
        .then((CourseList)=> CourseList.docs
        .map((CourseJson)=> CourseModel.fromJson(CourseJson.data()))
        .toList()
    );
  }
}