import 'package:flutter/material.dart';
import 'package:grade_flutter/database/course_dao.dart';
import 'package:grade_flutter/models/course.dart';

class CourseViewScreen extends StatefulWidget{
  const CourseViewScreen({super.key});

  @override
  State<CourseViewScreen> createState() => CourseViewScreenState();

}

class CourseViewScreenState extends State<CourseViewScreen>{

  List<Map<String, int>> semestres = [
    {"Semestre 1": 1},
    {"Semestre 2": 2},
    {"Semestre 3": 3},
    {"Semestre 4": 4},
    {"Semestre 5": 5},
    {"Semestre 6": 6},
    {"Semestre 7": 7},
    {"Semestre 8": 8},
    {"Optativas": 0},
  
  ];

  final CourseDao courseDao = CourseDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
            text: const TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.grading, size: 25),
                ),
                TextSpan(
                  text: " Minhas matérias",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
      ),
      body: ListView.builder(
        itemCount: semestres.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: RichText(
              text: TextSpan(
                children: [
                  const WidgetSpan(
                    child: Icon(Icons.bookmark_add, size: 25),
                  ),
                  TextSpan(
                    text: " ${semestres[index].keys.first}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            onTap: () async {
              // ignore: unused_local_variable
              List<Course> courses = [];
              if (semestres[index].values.first == 1) {
                courses = await courseDao.findAllCourses('materiasCC');
              } else {
                courses = await courseDao.findAllBySemester(semestres[index].values.first, 'materiasCC');
              }
            },
          );
        },
      )
    );
  }

}