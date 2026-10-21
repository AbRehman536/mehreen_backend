import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mehreen_backend/models/Course.dart';
import 'package:mehreen_backend/models/student.dart';
import 'package:mehreen_backend/services/course.dart';
import 'package:mehreen_backend/services/student.dart';

import '../../services/cloudinaryService.dart';

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
  XFile? selectedImage;

  List<CourseModel> courseList = [];
  CourseModel? selectedCourse;

  void _showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      final img = await CloudinaryService.pickImage(source: ImageSource.gallery);
                      if (img != null) {
                        setState(() {
                          selectedImage = img;
                        });
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.image, size: 50, color: Colors.green),
                        SizedBox(height: 8),
                        Text("Gallery"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      final img = await CloudinaryService.pickImage(source: ImageSource.camera);
                      if (img != null) {
                        setState(() {
                          selectedImage = img;
                        });
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.camera_alt, size: 50, color: Colors.green),
                        SizedBox(height: 8),
                        Text("Camera"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
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
          GestureDetector(
          onTap: () => _showImagePickerOption(context),
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: selectedImage != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: kIsWeb
                  ? Image.network(selectedImage!.path, fit: BoxFit.cover)
                  : Image.file(File(selectedImage!.path), fit: BoxFit.cover),
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                SizedBox(height: 8),
                Text("Tap to add product image"),
              ],
            ),
          ),
        ),
          const SizedBox(height: 15),
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
              String? imageUrl;
              if (selectedImage != null) {
                imageUrl = await CloudinaryService.uploadImage(selectedImage!);
                if (imageUrl == null) {
                  throw Exception("Failed to upload image to Cloudinary.");
                }
              }
              await StudentService().createStudent(
                  StudentModel(
                    image: imageUrl,
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
