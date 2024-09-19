import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/oauth2_authentication_service.dart';
import '../Services/database_services.dart';
import '../models/task.dart';
import '../models/tasks_data.dart';
import '../task_tile.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen(this.user);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task>? tasks;

  getTasks() async {
    tasks = await DatabaseServices.getTasks();
    Provider.of<TasksData>(context, listen: false).tasks = tasks!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    String loggedUserName = widget.user.displayName ?? '';
    return tasks == null
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.verified_user),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Text(loggedUserName,
                            style: TextStyle(color: Colors.grey, fontSize: 25))
                    ),
                    TextButton(onPressed: () {
                       context.read<Oauth2AuthenticationService>().signOut();
                    },
                        child: Text('Sign out')
                    )
                  ]
              ),
              centerTitle: true,
              backgroundColor: Colors.green,
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Todo Tasks (${Provider.of<TasksData>(context).tasks.length})',
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Consumer<TasksData>(
                    builder: (context, tasksData, child) {
                      return ListView.builder(
                          itemCount: tasksData.tasks.length,
                          itemBuilder: (context, index) {
                            Task task = tasksData.tasks[index];
                            return TaskTile(
                              task: task,
                              tasksData: tasksData,
                            );
                          });
                    },
                  ),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              child: const Icon(
                Icons.add,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const AddTaskScreen();
                    });
              },
            ),
          );
  }
}
