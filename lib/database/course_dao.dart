import 'package:grade_flutter/models/course.dart';
import 'package:sqflite/sqflite.dart';
import 'package:grade_flutter/database/courses_db.dart';

class CourseDao {

  static const String tabelaLC = 'materiasLC';
  static const String tabelaSI = 'materiasSI';
  static const String tabelaCC = 'materiasCC';
  static const String codigo = 'codigo';
  static const String nome = 'nome';
  static const String cargaHoraria = 'cargaHoraria';
  static const String semestre = 'semestre';
  static const String preRequisitos = 'preRequisitos';

  Set<String> toCompletedSet(List<Map<String, dynamic>> result) {
    final Set<String> completed = {};
    for (Map<String, dynamic> row in result) {
      final String course = row[codigo];
      completed.add(course);
    }
    return completed;
  }

  List<Course> toCourseList(List<Map<String, dynamic>> result) {
    final List<Course> courses = List<Course>.empty(growable: true);
    for (Map<String, dynamic> row in result) {
      final Course course = Course(
        codigo: row[codigo],
        nome: row[nome],
        cargaHoraria: row[cargaHoraria],
        semestre: row[semestre],
        prerequisitos: row[preRequisitos],
      );
      courses.add(course);
    }
    return courses;
  }

  Map<String, dynamic> toCourseMap(Course course) {
    final Map<String, dynamic> courseMap = {};
    courseMap[codigo] = course.codigo;
    courseMap[nome] = course.nome;
    courseMap[cargaHoraria] = course.cargaHoraria;
    courseMap[semestre] = course.semestre;
    courseMap[preRequisitos] = course.prerequisitos;
    return courseMap;
  }

  Future<Set<String>> findAllCompleted() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query("completed");
    final Set<String> courses = toCompletedSet(result);
    return courses;
  }

  Future<void> updateAllCompleted(Set<String> completed) async {
    final Database db = await getDatabase();
    await db.transaction((txn) async {
      await txn.delete('completed');
      for (String course in completed) {
        await txn.insert('completed', {'codigo': course});
      }
    });
  }

  Future<List<Course>> findAllCourses(String curso) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(curso);
    final List<Course> courses = toCourseList(result);
    return courses;
  }

  Future<List<Course>> findAllCoursesBySemester(int semester, String curso) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(curso, where: '$semestre = ?', whereArgs: [semester]);
    final List<Course> courses = toCourseList(result);
    return courses;
  }

  Future<int> countAllHoursBySemester (int semester, String curso) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(curso, where: '$semestre = ?', whereArgs: [semester]);
    final List<Course> courses = toCourseList(result);
    int totalHours = 0;
    for (Course course in courses) {
      totalHours += course.cargaHoraria;
    }
    return totalHours;
  }

}