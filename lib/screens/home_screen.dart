import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grade_flutter/auth/authenticator.dart';
import 'package:grade_flutter/screens/course_view_screen.dart';
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
        centerTitle: true,
        title: RichText(
            text: const TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.house, size: 25),
                ),
                TextSpan(
                  text: " Menu Principal",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
        actions: [
          IconButton(
            onPressed: () async {
              authenticator.signOut();
            },
            icon: const Icon(Icons.logout_outlined),
            tooltip: "Sair do app",
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Bem vindo(a), ${user.displayName}!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.75),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Selecione o curso que deseja visualizar a grade:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
               Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CourseViewScreen(nomeCurso: "CC",)));
              },
              child: const Text('Ciência da Computação', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CourseViewScreen(nomeCurso: "SI",)),
                );
              },
              child: const Text('Sistemas de Informação', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CourseViewScreen(nomeCurso: "LC",)),
                );
              },
              child: const Text('Licenciatura em Computação', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
