import 'package:flutter/material.dart';
import 'dart:core';
import 'package:grade_flutter/database/course_dao.dart';
import 'package:grade_flutter/screens/course_list.dart';

class CourseViewScreen extends StatefulWidget{
  const CourseViewScreen({super.key, required this.nomeCurso});

  final String nomeCurso;

  @override
  State<CourseViewScreen> createState() => CourseViewScreenState();

}

class CourseViewScreenState extends State<CourseViewScreen>{

  @override
  void initState() {
    super.initState();
    nome = widget.nomeCurso;
  }

  String nome = '';

  List<Map<String, int>> semestres = [
    {"Semestre 1": 1},
    {"Semestre 2": 2},
    {"Semestre 3": 3},
    {"Semestre 4": 4},
    {"Semestre 5": 5},
    {"Semestre 6": 6},
    {"Semestre 7": 7},
    {"Semestre 8": 8},
    {"Optativas": 0}
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
                  child: Icon(Icons.school_sharp, size: 25),
                ),
                TextSpan(
                  text: " Lista de semestres",
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
                    child: Icon(Icons.my_library_books_sharp, size: 25),
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
              List courses = [];
              int totalHours = 0;
              List all = [];
              if(nome == 'LC'){
                courses = await courseDao.findAllCoursesBySemester(semestres[index].values.first, 'materiasLC');
                totalHours = await courseDao.countAllHoursBySemester(semestres[index].values.first, 'materiasLC');
                all = await courseDao.findAllCourses('materiasLC');
              }
              else if(nome == 'SI'){
                courses = await courseDao.findAllCoursesBySemester(semestres[index].values.first, 'materiasSI');
                totalHours = await courseDao.countAllHoursBySemester(semestres[index].values.first, 'materiasSI');
                all = await courseDao.findAllCourses('materiasSI');
              }
              else if(nome == 'CC'){
                courses = await courseDao.findAllCoursesBySemester(semestres[index].values.first, 'materiasCC');
                totalHours = await courseDao.countAllHoursBySemester(semestres[index].values.first, 'materiasCC');
                all = await courseDao.findAllCourses('materiasCC');
              }
              Set<String> completed = await courseDao.findAllCompleted();
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseList(
                    courses: courses, 
                    semestre: semestres[index].values.first, 
                    horasTotais: totalHours,
                    all: all,
                    completed: completed,
                  ),
                ),
              );
            },
          );
        },
      )
    );
  }

}