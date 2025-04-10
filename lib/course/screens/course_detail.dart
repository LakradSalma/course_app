import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/course/course.dart';

class CourseDetail extends StatelessWidget {
  static const routeName = 'courseDetail';
  final Course course;

  const CourseDetail({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${course.code}', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () => Navigator.of(context).pushNamed(
              AddUpdateCourse.routeName,
              arguments: CourseArgument(course: course, edit: true),
            ),
          ),
          const SizedBox(width: 32),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white,),
            onPressed: () {
              // Demander au Bloc de gérer la suppression
              context.read<CourseBloc>().add(CourseDelete(course));
              // Fermer cette page sans réinitialiser l'ensemble de la pile de navigation
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Title: ${course.title}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  'ECTS: ${course.ects}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  course.description,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
