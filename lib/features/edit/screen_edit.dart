// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_bloc/features/model/get_model.dart';

import '../bloc/student_bloc.dart';

class ScreenEdit extends StatelessWidget {
  ScreenEdit({super.key, required this.obj});
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  StudentModel obj;

  @override
  Widget build(BuildContext context) {
    nameController.text = obj.name!;
    ageController.text = obj.age!;
    return BlocListener<StudentBloc, StudentState>(
      listenWhen: (previous, current) => current is StudentActionState,
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Student'),
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
                onPressed: () {
                  updatStudent(obj, context);
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

  updatStudent(StudentModel data, BuildContext context) {
    final name = nameController.text;
    final age = ageController.text;
    if (name.isNotEmpty && age.isNotEmpty) {
      final studentObj = StudentModel(name: name, age: age, id: data.id);
      context
          .read<StudentBloc>()
          .add(UpdateStudentSuccessEvent(obj: studentObj));
      context.read<StudentBloc>().add(FetchDataSuccessEvent());
    }
  }
}
