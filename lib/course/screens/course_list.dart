import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/course/bloc/bloc.dart';
import '/course/course.dart';

class CoursesList extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Courses'),
      ),
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (_, state) {
          if (state is CourseOperationFailure) {
            return Center(child: Text('Could not perform course operation'));
          }

          if (state is CoursesLoadSuccess) {
            final courses = state.courses;

            if (courses.isEmpty) {
              return Center(child: Text('No courses available.'));
            }

            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (_, idx) => ListTile(
                title: Text('${courses[idx].title}'),
                subtitle: Text('${courses[idx].code}'),
                onTap: () => Navigator.of(context).pushNamed(
                  CourseDetail.routeName,
                  arguments: courses[idx],
                ),
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          AddUpdateCourse.routeName,
          arguments: CourseArgument(edit: false, course: null), // course can now be null
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

class CourseArgument {
  final Course? course;  // Allow course to be nullable
  final bool edit;

  CourseArgument({required this.edit, this.course});
}
