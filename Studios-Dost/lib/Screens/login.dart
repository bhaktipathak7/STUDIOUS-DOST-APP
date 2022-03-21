import 'package:StudiosDost/Components/localdatabase.dart';
import 'package:StudiosDost/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<void> signIn() async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((value) {
          LocalDatabase.saveUserSharedPrefs(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
        });
      } on FirebaseAuthException catch (e) {
        SnackBar snackBar = SnackBar(content: Text(e.message!));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Login",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
            child: SizedBox(
          width: 300,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icon.png',
                  width: 200,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "Enter Email",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: "Enter Password",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      signIn();
                      emailController.clear();
                      passwordController.clear();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(18.0)),
                    child: const Center(
                        child: Text(
                      "Login",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
