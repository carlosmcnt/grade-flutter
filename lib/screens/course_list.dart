import 'package:flutter/material.dart';
import 'package:grade_flutter/database/course_dao.dart';
import 'package:grade_flutter/models/course.dart';

import '../utils/colors_const.dart';

class CourseList extends StatefulWidget{
  const CourseList({super.key, required this.courses, required this.semestre, required this.horasTotais, required this.all, required this.completed});

  final List<dynamic> courses;
  final int semestre;
  final int horasTotais;

  final List<dynamic> all;
  final Set<String> completed;

  @override
  State<CourseList> createState() => CourseListState();
}

class CourseListState extends State<CourseList>{

  final CourseDao courseDao = CourseDao();

  @override
  void initState() {
    super.initState();
    semestre = widget.semestre;
    horasTotais = widget.horasTotais;
  }

  int semestre = 0;
  int horasTotais = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
            text: TextSpan(
              children: [
                const WidgetSpan(
                  child: Icon(Icons.grading, size: 25),
                ),
                TextSpan(
                  text: (() {
                    if (semestre == 0) {
                      return " Optativas";
                    } else {
                      return " Semestre $semestre";
                    }
                  })(),
                  style: const TextStyle(
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
        itemCount: widget.courses.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                updateCompletedState(widget, context, index, courseDao);
              });
            },
            child: Card(
              color: getColor(widget, context, index),
              child: ListTile(
                title: RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Icon(Icons.computer_sharp, size: 25),
                      ),
                      TextSpan(
                        text: " ${widget.courses[index].nome}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                subtitle: RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Icon(Icons.code, size: 20),
                      ),
                      TextSpan(
                        text:
                        " Código: ${widget.courses[index].codigo}",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                trailing: RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Icon(Icons.timer, size: 20),
                      ),
                      TextSpan(
                        text:
                        " ${widget.courses[index].cargaHoraria}h",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: semestre > 0 ? SizedBox(
        height: 60,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Carga horária total do semestre: $horasTotais horas", 
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ) : const SizedBox(height: 0)
    );
  }
}

void updateCompletedState(CourseList widget, BuildContext context, int index, CourseDao courseDao) {
  Course course = widget.courses[index];
  if(widget.completed.contains(course.codigo)) {
    widget.completed.remove(course.codigo);
    validateCompleted(widget);
    courseDao.updateAllCompleted(widget.completed);
  }else{
    List<String> preReq = course.prerequisitos == null ? [] : course.prerequisitos!.split(", ");
    if(widget.completed.containsAll(preReq)) {
      widget.completed.add(course.codigo);
      courseDao.updateAllCompleted(widget.completed);
    }
  }
}

void validateCompleted(CourseList widget) {
  List<String> toRemove = [];
  for (var code in widget.completed) {
    dynamic ref;
    try {
      ref = widget.all.firstWhere((course) => course.codigo == code);
    }catch(ignored) {
      ref = null;
    }
    if(ref != null) {
      List<String> preReq = ref.prerequisitos == null ? [] : ref.prerequisitos!.split(", ");
      if(!widget.completed.containsAll(preReq)) {
        toRemove.add(code);
      }
    }
  }
  for (var code in toRemove) {
    widget.completed.remove(code);
    validateCompleted(widget);
  }
}

Color? getColor(CourseList widget, BuildContext context, int index) {
  Course course = widget.courses[index];
  if(widget.completed.contains(course.codigo)) {
    return Colors.green;
  }else{
    List<String> preReq = course.prerequisitos == null ? [] : course.prerequisitos!.split(", ");
    if(widget.completed.containsAll(preReq)) {
      return ColorsConst.indigo[300];
    }else{
      return Colors.red;
    }
  }
}