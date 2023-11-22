// ignore_for_file: file_names

class Course {

  final String codigo;
  final String nome;
  final int cargaHoraria;
  String? prerequisitos;
  final int semestre;

  Course({
    required this.codigo,
    required this.nome,
    required this.cargaHoraria,
    required this.semestre,
    this.prerequisitos,
  });

  @override
  String toString() {
    return 'Código: $codigo, Nome: $nome, Carga horaria: $cargaHoraria, Semestre: $semestre, Pré-requisitos: $prerequisitos';
  }

}