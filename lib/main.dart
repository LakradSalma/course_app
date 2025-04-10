import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'bloc_observer.dart';
import 'course/course.dart';
import 'course/screens/CourseListScreen .dart'; // fixed extra space

void main() {
  Bloc.observer = SimpleBlocObserver();

  final CourseRepository courseRepository = CourseRepository(
    dataProvider: CourseDataProvider(
      httpClient: http.Client(),
    ),
  );

  runApp(
    CourseApp(courseRepository: courseRepository),
  );
}

class CourseApp extends StatelessWidget {
  final CourseRepository courseRepository;

  const CourseApp({Key? key, required this.courseRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: courseRepository,
      child: BlocProvider(
        create: (context) =>
            CourseBloc(courseRepository: courseRepository)..add(CourseLoad()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Course App',
          theme: ThemeData(
            primarySwatch: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: CourseAppRoute.generateRoute,
          home: CourseListScreen(),
        ),
      ),
    );
  }
}
