import 'package:StudiosDost/Components/database.dart';
import 'package:flutter/material.dart';

class AddSpi extends StatefulWidget {
  final String userId;
  const AddSpi({Key? key, required this.userId})
      : super(key: key);

  @override
  State<AddSpi> createState() => _AddSpiState();
}

class _AddSpiState extends State<AddSpi> {
  TextEditingController sem1Controller = TextEditingController(text: "0");
  TextEditingController sem2Controller = TextEditingController(text: "0");
  TextEditingController sem3Controller = TextEditingController(text: "0");
  TextEditingController sem4Controller = TextEditingController(text: "0");
  TextEditingController sem5Controller = TextEditingController(text: "0");
  TextEditingController sem6Controller = TextEditingController(text: "0");
  final formkey = GlobalKey<FormState>();

  addData() async {
    if (formkey.currentState!.validate()) {
      Map<String, dynamic> data = {
        'sem1': sem1Controller.text.trim(),
        'sem2': sem2Controller.text.trim(),
        'sem3': sem5Controller.text.trim(),
        'sem4': sem4Controller.text.trim(),
        'sem5': sem5Controller.text.trim(),
        'sem6': sem6Controller.text.trim(),
        "id": widget.userId
      };
      Database().addSpis(data, widget.userId, widget.userId).then((val) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add SPI"),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    controller: sem1Controller,
                    decoration: InputDecoration(
                        hintText: "Enter Semester 1 SPI",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    controller: sem2Controller,
                    decoration: InputDecoration(
                        hintText: "Enter Semester 2 SPI",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    controller: sem3Controller,
                    decoration: InputDecoration(
                        hintText: "Enter Semester 3 SPI",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    controller: sem4Controller,
                    decoration: InputDecoration(
                        hintText: "Enter Semester 4 SPI",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    controller: sem5Controller,
                    decoration: InputDecoration(
                        hintText: "Enter Semester 5 SPI",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    controller: sem6Controller,
                    decoration: InputDecoration(
                        hintText: "Enter Semester 6 SPI",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (sem1Controller.text.isNotEmpty &&
                          sem2Controller.text.isNotEmpty) {
                        addData();
                        sem1Controller.clear();
                        sem2Controller.clear();
                        sem3Controller.clear();
                        sem4Controller.clear();
                        sem5Controller.clear();
                        sem6Controller.clear();
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
                        "Add",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
