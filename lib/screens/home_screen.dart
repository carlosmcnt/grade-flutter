import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grade_flutter/auth/authenticator.dart';

class Curso {
  final String nome;

  Curso(this.nome);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User user = auth.currentUser ??
        snackbarError(message: 'erro no usuário', context: context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Grade UFBA"),
        actions: [
          IconButton(
            onPressed: () async {
              await Authenticator().signOut();
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            icon: const Icon(Icons.logout),
            tooltip: "Sair",
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Text("Bem vindo, ${user.email}"),
          ),
          menuCursos()
        ],
      ),
    );
  }
}

class menuCursos extends StatelessWidget {
  menuCursos({super.key});

  final cursos = [
    Curso("Escova"),
    Curso("Sabonete"),
    Curso("Condicionador"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Center(
      //     child: Text('Cursos'),
      //   ),
      // ),
      body: Center(
        child: ListView.builder(
          itemCount: cursos.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(cursos[index].nome));
          },
        ),
      ),
    );
  }
}
