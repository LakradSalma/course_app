import '../data_provider/course_data.dart';
import '../models/course.dart';

class CourseRepository {
  final CourseDataProvider dataProvider;

  CourseRepository({required this.dataProvider});

  // Méthode pour créer un cours
  Future<Course> createCourse(Course course) async {
    try {
      // S'assurer que l'ID ne soit pas envoyé si la base de données le génère
      final Course createdCourse = await dataProvider.createCourse(course);
      return createdCourse;
    } catch (error) {
      throw Exception('Failed to create course: $error');
    }
  }

  // Méthode pour récupérer les cours
  Future<List<Course>> getCourses() async {
    try {
      final List<Course> courses = await dataProvider.getCourses();
      return courses;
    } catch (error) {
      throw Exception('Failed to load courses: $error');
    }
  }

  // Méthode pour mettre à jour un cours
  Future<void> updateCourse(Course course) async {
    try {
      await dataProvider.updateCourse(course);
    } catch (error) {
      throw Exception('Failed to update course: $error');
    }
  }

  // Méthode pour supprimer un cours
  Future<void> deleteCourse(String id) async {
    try {
      await dataProvider.deleteCourse(id);
    } catch (error) {
      throw Exception('Failed to delete course: $error');
    }
  }
}
