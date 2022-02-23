import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_list/repositories/tasks_repository.dart';
import 'package:todo_list/widgets/task_list_item.dart';
import 'package:todo_list/models/task.dart';
import 'package:flutter/scheduler.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController tasksController = TextEditingController();
  final TaskRepository taskRepository = TaskRepository();

  List<Task> tasks = [];

  Task? deletedTask;
  int? deletedTaskPos;

  String? errorText;

  @override
  void initState(){
    super.initState();

    taskRepository.getTaskList().then((value) {
      setState(() {
        tasks = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: tasksController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adicione uma tarefa',
                          labelStyle: TextStyle(
                            color: Colors.purple,
                          ),
                          hintText: 'Ex.: Estudar Flutter',
                          errorText: errorText,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple,
                              width: 3,
                            )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        String text = tasksController.text;

                        if(text.isEmpty){
                          setState(() {
                            errorText = 'A tarefa não pode estar vazia.';
                          });
                          return;
                        }

                        setState(() {
                          Task newTask = Task(
                            title: text,
                            dateTime: DateTime.now(),
                          );
                          tasks.add(newTask);
                          errorText = null;
                        });
                        tasksController.clear();
                        taskRepository.saveTaskList(tasks);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        padding: EdgeInsets.all(14),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Task task in tasks)
                        TaskListItem(
                          task: task,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Você possui ${tasks.length} tarefas pendentes.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: showDeleteTasksConfirmationDialog,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        padding: EdgeInsets.all(14),
                      ),
                      child: Icon(
                        Icons.delete,
                        size: 15,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Task task) {
    deletedTask = task;
    deletedTaskPos = tasks.indexOf(task);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        tasks.remove(task);
      });
      taskRepository.saveTaskList(tasks);
    });


    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Tarefa ${task.title} deletada com sucesso.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.purple,
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              tasks.insert(deletedTaskPos!, deletedTask!);
            });
            taskRepository.saveTaskList(tasks);
          },
        ),
        duration: const Duration(seconds: 5),
    ));
  }

  void deleteAllTasks(){
    setState(() {
      tasks.clear();
    });
    taskRepository.saveTaskList(tasks);
  }

  void showDeleteTasksConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Limpar todas as tarefas?'),
            content: Text(
                'Você tem certeza que deseja deletar todas as tarefas?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  deleteAllTasks();

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Todas as tarefas foram deletadas.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ));
                },
                child: Text(
                  'Limpar tarefas',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
    );

  }
}
