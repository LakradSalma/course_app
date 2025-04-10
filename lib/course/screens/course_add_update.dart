import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/course/course.dart';

class AddUpdateCourse extends StatefulWidget {
  static const routeName = 'courseAddUpdate';
  final CourseArgument args;

  const AddUpdateCourse({Key? key, required this.args}) : super(key: key);

  @override
  _AddUpdateCourseState createState() => _AddUpdateCourseState();
}

class _AddUpdateCourseState extends State<AddUpdateCourse> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _course = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.args.edit ? "Edit Course" : "Add New Course",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Course Code
              TextFormField(
                initialValue: widget.args.edit ? widget.args.course?.code : '',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter course code';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Course Code',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  setState(() {
                    _course["code"] = value;
                  });
                },
              ),
              const SizedBox(height: 12),

              // Course Title
              TextFormField(
                initialValue: widget.args.edit ? widget.args.course?.title : '',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter course title';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Course Title',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  setState(() {
                    _course["title"] = value;
                  });
                },
              ),
              const SizedBox(height: 12),

              // Course ECTS
              TextFormField(
                initialValue:
                    widget.args.edit ? widget.args.course?.ects.toString() : '',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter course ECTS';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number for ECTS';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Course ECTS',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  setState(() {
                    _course["ects"] = int.parse(value!);
                  });
                },
              ),
              const SizedBox(height: 12),

              // Course Description
              TextFormField(
                initialValue:
                    widget.args.edit ? widget.args.course?.description : '',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter course description';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Course Description',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  setState(() {
                    _course["description"] = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Save Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form!.validate()) {
                      form.save();
                      final CourseEvent event =
                          widget.args.edit
                              ? CourseUpdate(
                                Course(
                                  id: widget.args.course!.id,
                                  code: _course["code"],
                                  title: _course["title"],
                                  ects: _course["ects"],
                                  description: _course["description"],
                                ),
                              )
                              : CourseCreate(
                                Course(
                                  code: _course["code"],
                                  title: _course["title"],
                                  ects: _course["ects"],
                                  description: _course["description"],
                                  id: '',
                                ),
                              );

                      // Trigger the BLoC event
                      BlocProvider.of<CourseBloc>(context).add(event);

                      // Wait for result before popping
                      Navigator.of(
                        context,
                      ).pop(); // Go back to the previous screen
                    }
                  },
                  label: Text('SAVE', style: TextStyle(color: Colors.white)),
                  icon: const Icon(Icons.save, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
