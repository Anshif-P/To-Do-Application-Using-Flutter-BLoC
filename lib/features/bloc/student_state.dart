part of 'student_bloc.dart';

abstract class StudentState {}

abstract class StudentActionState extends StudentState {}

final class StudentInitial extends StudentState {}

class AddStudentState extends StudentState {}



class AddStudentSuccessMessageSatate extends StudentActionState {}

class DataFetchSuccessState extends StudentState {
  List<StudentModel>? studentList = [];

  DataFetchSuccessState({required this.studentList});
}

class AddStudentNavigationState extends StudentActionState {}

class LoadingFetchState extends StudentState {}

class UpdateStudentSuccessState extends StudentState {}

class UpdateStudentSuccessMessageSatate extends StudentActionState {}

class DeleteStudentState extends StudentState {}

class DeleteStudentSuccessMessageSatate extends StudentActionState {}

class ErrorFetchDataState extends StudentState {}
