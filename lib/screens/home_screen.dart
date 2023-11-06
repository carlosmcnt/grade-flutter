import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grade_flutter/auth/authenticator.dart';  

class HomeScreen extends StatefulWidget {
  
  final User user;

  const HomeScreen({super.key, required this.user});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Text("Bem vindo, ${widget.user.email}"),
      ),
    );
  }
}