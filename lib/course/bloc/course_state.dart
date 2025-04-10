import 'package:equatable/equatable.dart';
import '/course/course.dart';

class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props => [];
}

// L'état initial lorsque l'application commence, avant de charger des données.
class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CoursesLoadSuccess extends CourseState {
  final List<Course> courses;

  CoursesLoadSuccess([this.courses = const []]);

  @override
  List<Object> get props => [courses];
}

class CourseOperationFailure extends CourseState {
  final String error;

  CourseOperationFailure({required this.error});

  @override
  List<Object> get props => [error];
}
