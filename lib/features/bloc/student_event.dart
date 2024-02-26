part of 'student_bloc.dart';

abstract class StudentEvent {}

class FetchDataSuccessEvent extends StudentEvent {}

class AddStudentSuccessEvent extends StudentEvent {
  StudentModel? obj;
  AddStudentSuccessEvent({required this.obj});
}

class AddPageNavigationEvent extends StudentEvent {}

class UpdateStudentSuccessEvent extends StudentEvent {
  StudentModel? obj;
  UpdateStudentSuccessEvent({required this.obj});
}

class DeleteStudentSuccessEvent extends StudentEvent {
  String id;
  DeleteStudentSuccessEvent({required this.id});
}
