// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_bloc/features/edit/screen_edit.dart';

import '../../add/screen_add.dart';
import '../../bloc/student_bloc.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<StudentBloc>().add(FetchDataSuccessEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<StudentBloc>().add(AddPageNavigationEvent());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.read<StudentBloc>().add(FetchDataSuccessEvent());
              },
              icon: const Icon(Icons.replay_outlined))
        ],
        backgroundColor: Colors.blue[900],
        title: const Text('ToDo'),
      ),
      body: BlocConsumer<StudentBloc, StudentState>(
        listenWhen: (previous, current) => current is StudentActionState,
        buildWhen: (previous, current) => current is! StudentActionState,
        listener: (context, state) {
          if (state is AddStudentNavigationState) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ScreenAdd()),
            );
          }
        },
        builder: (context, state) {
          if (state is DataFetchSuccessState) {
            return state.studentList != null
                ? ListView.builder(
                    itemCount: state.studentList!.length,
                    itemBuilder: (context, index) {
                      final data = state.studentList![index];

                      return ListTile(
                        title: Text(data.name!),
                        subtitle: Text(data.age!),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ScreenEdit(obj: data)));
                            } else if (value == 'delete') {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Delete Student'),
                                    content: const Text(
                                        'Are you sure you want to delete'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Delete'),
                                        onPressed: () {
                                          // Delete the student
                                          context.read<StudentBloc>().add(
                                              DeleteStudentSuccessEvent(
                                                  id: data.id!));
                                          context
                                              .read<StudentBloc>()
                                              .add(FetchDataSuccessEvent());
                                          // Close the dialog
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          itemBuilder: (context) => <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'edit',
                              child: ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Delete'),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('No Data Found'),
                  );
          } else if (state is LoadingFetchState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else if (state is ErrorFetchDataState) {
            return const Center(
              child: Text(
                'No Data Found',
                style: TextStyle(color: Colors.black),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
