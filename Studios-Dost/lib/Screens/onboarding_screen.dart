import 'package:StudiosDost/Screens/login.dart';
import 'package:StudiosDost/Screens/signup.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon.png',
              width: 200,
            ),
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/splash.png',
              width: MediaQuery.of(context).size.width / 1.2,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Your Every Companion",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              "A Virtual Dost that cares for you",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp())),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                    color: Colors.green[600],
                    borderRadius: BorderRadius.circular(18.0)),
                child: const Center(
                    child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login())),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(18.0)),
                child: const Center(
                    child: Text(
                  "Sign In",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
