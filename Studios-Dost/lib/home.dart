import 'package:StudiosDost/Components/authentication.dart';
import 'package:StudiosDost/Components/localdatabase.dart';
import 'package:StudiosDost/Screens/onboarding_screen.dart';
import 'package:StudiosDost/Screens/progress.dart';
import 'package:StudiosDost/Screens/shedule.dart';
import 'package:StudiosDost/Screens/todolist.dart';
import 'package:StudiosDost/Screens/water_tracker.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:quotes/quotes.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = " ";
  String userId = " ";
  String quote = " ";
  String author = " ";
  @override
  void initState() {
    getName();
    getQuote();
    super.initState();
  }

  void getName() async {
    name = (await LocalDatabase.getNameKey())!;
    userId = (await LocalDatabase.getUserId())!;
    setState(() {});
  }

  void getQuote() {
    quote = Quotes.getRandom().getContent();
    author = Quotes.getRandom().getAuthor();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
          actions: [
            IconButton(
              onPressed: () {
                AuthMethord().signOut();
                LocalDatabase.saveUserSharedPrefs(false);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OnBoardingScreen()));
              },
              icon: const Icon(Icons.exit_to_app),
            )
          ],
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  quote,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "~By " + author,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const TodoListPage()))),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: Colors.blue),
                      child: const Icon(
                        Icons.checklist_outlined,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>  ProgressPage(userId: userId,)))),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: Colors.yellow[900]),
                      child: const Icon(
                        Icons.trending_up_outlined,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShedulePage())),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: Colors.green),
                      child: const Icon(
                        Icons.today_outlined,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WaterTracker(
                                  userId: userId,
                                ))),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: Colors.cyan),
                      child: const Icon(
                        Icons.water_drop_outlined,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
