import 'dart:convert';
import '/course/models/course.dart';
import 'package:http/http.dart' as http;

class CourseDataProvider {
  final String _baseUrl = 'http://192.168.52.202:3200';
  final http.Client httpClient;

  CourseDataProvider({required this.httpClient});

  // Create a course
  Future<Course> createCourse(Course course) async {
    final response = await httpClient.post(
      Uri.parse('$_baseUrl/courses'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': course.title,
        'code': course.code,
        'description': course.description,
        'ects': course.ects,
      }),
    );

    if (response.statusCode == 201) {
      // Successful creation returns the course created
      return Course.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Failed to create course: ${response.statusCode} - ${response.body}',
      );
    }
  }

  // Get all courses
  Future<List<Course>> getCourses() async {
    final response = await httpClient.get(Uri.parse('$_baseUrl/courses'));

    if (response.statusCode == 200) {
      final List<dynamic> coursesJson = jsonDecode(response.body);
      return coursesJson
          .map((courseJson) => Course.fromJson(courseJson))
          .toList();
    } else {
      throw Exception(
        'Failed to load courses: ${response.statusCode} - ${response.body}',
      );
    }
  }

  // Delete a course
  Future<void> deleteCourse(String id) async {
    final response = await httpClient.delete(
      Uri.parse('$_baseUrl/courses/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception(
        'Failed to delete course: ${response.statusCode} - ${response.body}',
      );
    }
  }

  // Update a course
  Future<void> updateCourse(Course course) async {
    final response = await httpClient.put(
      Uri.parse('$_baseUrl/courses/${course.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': course.id,
        'title': course.title,
        'code': course.code,
        'description': course.description,
        'ects': course.ects,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to update course: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
