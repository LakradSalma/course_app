import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/course/course.dart';

class CourseListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cours', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // Naviguer vers l'écran d'ajout de cours
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => AddUpdateCourse(
                        args: CourseArgument(
                          edit:
                              false, // Ou `true` si vous modifiez un cours existant
                          course:
                              null, // Remplissez cette valeur si vous éditez un cours
                        ),
                      ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is CourseLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is CoursesLoadSuccess) {
            return ListView.builder(
              itemCount: state.courses.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text(
                      state.courses[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      state.courses[index].code,
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.blueAccent,
                    ),
                    onTap: () {
                      // Naviguer vers l'écran des détails du cours
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  CourseDetail(course: state.courses[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          if (state is CourseOperationFailure) {
            return Center(child: Text('Erreur: ${state.error}'));
          }

          return Center(child: Text('Aucun cours disponible.'));
        },
      ),
    );
  }
}
