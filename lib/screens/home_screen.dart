import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grade_flutter/auth/authenticator.dart';
class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key, required this.user});
  final User user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Authenticator authenticator = Authenticator();

  @override
  Widget build(BuildContext context) {
    User user = auth.currentUser ?? snackbarError(message: 'Erro ao reconhecer usuário', context: context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Grade UFBA"),
        actions: [
          IconButton(
            onPressed: () async {
              authenticator.signOut();
            },
            icon: const Icon(Icons.logout_outlined),
            tooltip: "Sair",
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Bem vindo(a), ${user.displayName}!",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Selecione o curso que deseja visualizar a grade:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuMateriasCC()),
                );
              },
              child: const Text('Ciência da Computação'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuMateriasSI()),
                );
              },
              child: const Text('Sistemas de Informação'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuMateriasLC()),
                );
              },
              child: const Text('Licenciatura em Computação'),
            ),
          ],
        ),
      ),
    );
  }
}

class Materia {
  final String nome;
  final String codigo;
  final int cargaHoraria;
  final String prerequisitos;
  final int semestre;

  Materia(this.codigo, this.nome, this.cargaHoraria, this.prerequisitos, this.semestre);
}

class MenuMateriasCC extends StatelessWidget {
  MenuMateriasCC({super.key});

  final materiasCC = [
    Materia("MATA02", "Cálculo 1", 90, "Nenhum", 1),
    Materia("MATA01", "Geométria Analítica", 60, "Nenhum", 1),
    Materia("MATA37", "Introdução à Lógica de Programação", 60, "Nenhum", 1),
    Materia("MATA39", "Seminários de Introdução ao Curso", 45, "Nenhum", 1),
    Materia("MATA42", "Matemática Discreta I", 60, "Nenhum", 1),
    Materia("MATA38", "Projeto de Circuitos Lógicos", 60, "Nenhum", 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Center(
      //     child: Text('Materias'),
      //   ),
      // ),
      body: Center(
        child: ListView.builder(
          itemCount: materiasCC.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(materiasCC[index].nome), 
            subtitle: Text(materiasCC[index].codigo), 
            textColor: Colors.white,);
          },
        ),
      ),
    );
  }
}

class MenuMateriasSI extends StatelessWidget {
  MenuMateriasSI({super.key});

  final materiasSI = [
    Materia("MATA02", "Cálculo 1", 90, "Nenhum", 1),
    Materia("MATA68", "Computador, Ética e Sociedade", 45, "Nenhum", 1),
    Materia("MATA37", "Introdução à Lógica de Programação", 60, "Nenhum", 1),
    Materia("MATA39", "Seminários de Introdução ao Curso", 45, "Nenhum", 1),
    Materia("MATA42", "Matemática Discreta I", 60, "Nenhum", 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Center(
      //     child: Text('Materias'),
      //   ),
      // ),
      body: Center(
        child: ListView.builder(
          itemCount: materiasSI.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(materiasSI[index].nome), 
            subtitle: Text(materiasSI[index].codigo), 
            textColor: Colors.white,);
          },
        ),
      ),
    );
  }
}


class MenuMateriasLC extends StatelessWidget {
  MenuMateriasLC({super.key});

  final materiasLC = [
    Materia("EDCB80", "Filosofia da Educação", 60, "Nenhum", 1),
    Materia("MATA01", "Geométria Analítica", 60, "Nenhum", 1),
    Materia("MATA37", "Introdução à Lógica de Programação", 60, "Nenhum", 1),
    Materia("MATA39", "Seminários de Introdução ao Curso", 45, "Nenhum", 1),
    Materia("MATA42", "Matemática Discreta I", 60, "Nenhum", 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Center(
      //     child: Text('Materias'),
      //   ),
      // ),
      body: Center(
        child: ListView.builder(
          itemCount: materiasLC.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(materiasLC[index].nome), 
            subtitle: Text(materiasLC[index].codigo), 
            textColor: Colors.white,);
          },
        ),
      ),
    );
  }
}




