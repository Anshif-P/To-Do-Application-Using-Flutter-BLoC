// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_bloc/features/home/ui/screen_home.dart';
import 'package:todo_with_bloc/features/model/get_model.dart';

import '../bloc/student_bloc.dart';

class ScreenAdd extends StatelessWidget {
  ScreenAdd({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentBloc, StudentState>(
      listenWhen: (previous, current) => current is StudentActionState,
      listener: (context, state) {
        if (state is AddStudentSuccessMessageSatate) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Student Added')));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Student'),
          backgroundColor: Colors.blue[900],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Age',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(160, 40)),
                  backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
                ),
                onPressed: () async {
                  addStudent(context);
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addStudent(BuildContext context) async {
    final name = nameController.text;
    final age = ageController.text;
    if (name.isNotEmpty && age.isNotEmpty) {
      StudentModel? studentObj = StudentModel(name: name, age: age);
      context.read<StudentBloc>().add(AddStudentSuccessEvent(obj: studentObj));
      context.read<StudentBloc>().add(FetchDataSuccessEvent());
    }
  }
}
