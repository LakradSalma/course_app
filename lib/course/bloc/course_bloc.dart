import 'package:flutter_bloc/flutter_bloc.dart';
import '/course/course.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {

  final CourseRepository courseRepository;

  CourseBloc({required this.courseRepository}) : super(CourseInitial()) {
    // Écouter l'événement CourseLoad
    on<CourseLoad>((event, emit) async {
      try {
        emit(CourseLoading());
        final courses = await courseRepository.getCourses();
        emit(CoursesLoadSuccess(courses));
      } catch (error) {
        emit(CourseOperationFailure(error: error.toString()));
      }
    });

    // Écouter l'événement CourseCreate
    on<CourseCreate>((event, emit) async {
      try {
        await courseRepository.createCourse(event.course);
        final courses = await courseRepository.getCourses();
        emit(CoursesLoadSuccess(courses));
      } catch (error) {
        emit(CourseOperationFailure(error: error.toString()));
      }
    });

    // Écouter l'événement CourseUpdate
    on<CourseUpdate>((event, emit) async {
      try {
        await courseRepository.updateCourse(event.course);
        final courses = await courseRepository.getCourses();
        emit(CoursesLoadSuccess(courses));
      } catch (error) {
        emit(CourseOperationFailure(error: error.toString()));
      }
    });

    // Écouter l'événement CourseDelete
    on<CourseDelete>((event, emit) async {
      try {
        await courseRepository.deleteCourse(event.course.id);
        final courses = await courseRepository.getCourses();
        emit(CoursesLoadSuccess(courses));
      } catch (error) {
        emit(CourseOperationFailure(error: error.toString()));
      }
    });
  }
}
