import 'package:StudiosDost/Components/database.dart';
import 'package:StudiosDost/Components/localdatabase.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/async.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _textEditingController = TextEditingController();
  String id = "";
  String userId = "";
  generateId() async {
    id = await nanoid(10);
    setState(() {});
  }

  void addTask() async {
    Map<String, dynamic> data = {"task": _textEditingController.text, "id": id};
    Database().addTask(data, userId, id).then((val) {
      Navigator.pop(context);
    });
    setState(() {});
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    generateId();
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    addTask();
                  },
                  child: const Text(
                    "Create",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ))
            ],
            title: const Text('Add Task'),
            content: TextField(
              onChanged: (value) {},
              controller: _textEditingController,
              decoration: const InputDecoration(hintText: "Enter Task"),
            ),
          );
        });
  }

  Stream? taskStream;
  Widget taskTile() => StreamBuilder(
      stream: taskStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return TaskTile(
                    title: snapshot.data.docs[index]["task"],
                    subtitle: snapshot.data.docs[index]["id"],
                    userId: userId,
                  );
                })
            : const Center(
                child: CircularProgressIndicator(),
              );
      });
  @override
  void initState() {
    getTasks();
    super.initState();
  }

  getTasks() async {
    userId = (await LocalDatabase.getUserId())!;

    Database().getTasks(userId).then((val) {
      taskStream = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        elevation: 0,
      ),
      body:
          Container(margin: const EdgeInsets.only(top: 10), child: taskTile()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayTextInputDialog(context),
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final String title, subtitle, userId;
  const TaskTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
        icon: const Icon(Icons.check_circle_outline),
        onPressed: () {
          Database().deleteTasks(userId, subtitle);
        },
      ),
      leading: CircleAvatar(
        child: Text(title[0]),
      ),
      title: Text(title),
    );
  }
}
