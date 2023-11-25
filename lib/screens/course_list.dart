import 'package:flutter/material.dart';
import 'package:grade_flutter/database/course_dao.dart';

class CourseList extends StatefulWidget{
  const CourseList({super.key, required this.courses, required this.semestre, required this.horasTotais});

  final List<dynamic> courses;
  final int semestre;
  final int horasTotais;
  
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
                  text: " Minhas matérias - $semestreº semestre",
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
          return ListTile(
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
                      color: Colors.white
                    ),
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
                    text: " Código: ${widget.courses[index].codigo}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
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
                    text: " ${widget.courses[index].cargaHoraria}h",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SizedBox(
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
      )
    );
  }
}