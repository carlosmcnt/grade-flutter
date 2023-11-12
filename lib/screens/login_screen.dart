import 'package:flutter/material.dart';
import 'package:grade_flutter/auth/authenticator.dart';
import 'package:grade_flutter/utils/colors_const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController submitController = TextEditingController();

  final key = GlobalKey<FormState>();
  Authenticator authenticator = Authenticator();

  bool firstAccess = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: ColorsConst.blueGray[50],
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.all(65),
              child: Form(
                key: key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      "assets/images/logo-computacao.png",
                      height: 150,
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Aplicativo Minha Grade UFBA",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      "Faça login para visualizar a sua grade de horários",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(label: Text("E-mail")),
                      validator: (value) {
                        if (value == null || value == "") {
                          return "O e-mail não pode ser vazio.";
                        }
                        if (!value.contains("@") ||
                            !value.contains(".") ||
                            value.length < 4) {
                          return "O e-mail deve possuir um formato válido.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(label: Text("Senha")),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "A senha deve possuir pelo menos 6 caracteres.";
                        }
                        return null;
                      },
                    ),
                    Visibility(
                        visible: !firstAccess,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: submitController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                label: Text("Confirme a senha"),
                              ),
                              validator: (value) {
                                if (value == null || value.length < 6) {
                                  return "A senha deve possuir pelo menos 6 caracteres.";
                                }
                                if (value != passwordController.text) {
                                  return "As senhas devem ser iguais.";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                label: Text("Nome"),
                              ),
                              validator: (value) {
                                if (value == null || value.length < 5) {
                                  return "O nome deve possuir pelo menos 5 caracteres.";
                                }
                                return null;
                              },
                            ),
                          ],
                        )),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        send();
                      },
                      child: Text(
                        (firstAccess) ? "Entrar" : "Cadastre-se",
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          firstAccess = !firstAccess;
                          clear();
                        });
                      },
                      child: Text(
                        (firstAccess) ? "Cadastrar" : "Voltar",
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  send() {
    String email = emailController.text;
    String senha = passwordController.text;
    String nome = nameController.text;

    if (key.currentState!.validate()) {
      if (firstAccess) {
        entrar(email: email, senha: senha);
      } else {
        criarUsuario(email: email, senha: senha, nome: nome);
      }
    }
  }

  entrar({required String email, required String senha}) async {
    authenticator.signIn(email: email, password: senha).then((String? value) {
      if (value != null) {
        snackbarError(message: value, context: context);
      } else {
        snackbarOk(message: "Login realizado com sucesso!", context: context);
      }
    });
  }

  criarUsuario(
      {required String email,
      required String senha,
      required String nome}) async {
    authenticator
        .signUp(email: email, password: senha, name: nome)
        .then((String? value) {
      if (value != null) {
        snackbarError(message: value, context: context);
      } else {
        snackbarOk(message: "Usuário criado com sucesso!", context: context);
      }
    });
  }

  clear(){
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    submitController.clear();
  }

}
