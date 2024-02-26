import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:todo_with_bloc/features/model/get_model.dart';
part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<AddStudentSuccessEvent>(addStudentEvent);
    on<FetchDataSuccessEvent>(fetchDataFromApiEvent);
    on<AddPageNavigationEvent>(addPageNavigationEvent);
    on<UpdateStudentSuccessEvent>(updateStudentSuccessEvent);
    on<DeleteStudentSuccessEvent>(deleteStudentSuccessEvent);
  }

  FutureOr<void> addStudentEvent(
      AddStudentSuccessEvent event, Emitter<StudentState> emit) async {
    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    StudentModel obj = event.obj as StudentModel;
    final data = StudentModel.toMap(obj);
    final body = jsonEncode(data);
    final jsonBody = await http
        .post(uri, body: body, headers: {'Content-Type': 'application/json'});

    if (jsonBody.statusCode == 200) {
      emit(AddStudentState());
    }
    emit(AddStudentSuccessMessageSatate());
  }

  FutureOr<void> fetchDataFromApiEvent(
      FetchDataSuccessEvent event, Emitter<StudentState> emit) async {
    emit(LoadingFetchState());
    List<StudentModel> data;
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final result = json['items'] as List;

      data = result.map((e) => StudentModel.fromJson(e)).toList();
      if (data.isEmpty) {
        emit(ErrorFetchDataState());
      } else {
        emit(DataFetchSuccessState(studentList: data));
      }
    }
  }

  FutureOr<void> addPageNavigationEvent(
      AddPageNavigationEvent event, Emitter<StudentState> emit) {
    emit(AddStudentNavigationState());
  }

  FutureOr<void> updateStudentSuccessEvent(
      UpdateStudentSuccessEvent event, Emitter<StudentState> emit) async {
    final id = event.obj!.id!;
    final obj = event.obj as StudentModel;
    final url = 'https://api.nstack.in/v1/todos/${id}';
    final uri = Uri.parse(url);
    final data = StudentModel.toMap(obj);
    final json = jsonEncode(data);
    final response = await http
        .put(uri, body: json, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      emit(UpdateStudentSuccessState());
      emit(UpdateStudentSuccessMessageSatate());
    }
  }

  FutureOr<void> deleteStudentSuccessEvent(
      DeleteStudentSuccessEvent event, Emitter<StudentState> emit) async {
    String id = event.id;
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response =
        await http.delete(uri, headers: {'accept': 'application/json'});
  }
}
