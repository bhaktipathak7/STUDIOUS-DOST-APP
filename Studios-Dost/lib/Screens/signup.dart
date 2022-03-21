import 'package:StudiosDost/Components/database.dart';
import 'package:StudiosDost/Components/localdatabase.dart';
import 'package:StudiosDost/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/async.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String id = "";
  @override
  void initState() {
    super.initState();
    generateId();
  }

  generateId() async {
    id = await nanoid(10);
    setState(() {});
  }

  String name = " ";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Future<void> signUp(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        "username": usernameController.text,
        "email": emailController.text,
        "id": id
      };
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        Database().createUser(userData, id).then((val) {});
        LocalDatabase.saveUserSharedPrefs(true);
        name = await Database().getUserName(id);
        LocalDatabase.saveUserNameSharedPrefs(name);
        LocalDatabase.saveUserId(id);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
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
            "SignUp",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
            child: SizedBox(
          width: 300,
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icon.png',
                  width: 200,
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      hintText: "Enter Username",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
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
                        passwordController.text.isNotEmpty &&
                        usernameController.text.isNotEmpty) {
                      signUp(context);
                      emailController.clear();
                      passwordController.clear();
                      usernameController.clear();
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
                      "SignUp",
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
