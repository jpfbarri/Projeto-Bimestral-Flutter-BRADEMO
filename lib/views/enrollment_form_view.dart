import 'package:flutter/material.dart';

import '../models/course.dart';
import '../theme/app_theme.dart';

class EnrollmentFormView extends StatefulWidget {
  const EnrollmentFormView({
    super.key,
    this.selectedCourse,
    this.embedded = false,
  });

  final Course? selectedCourse;
  final bool embedded;

  @override
  State<EnrollmentFormView> createState() => _EnrollmentFormViewState();
}

class _EnrollmentFormViewState extends State<EnrollmentFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _studentIdController = TextEditingController();
  Course? _course;

  @override
  void initState() {
    super.initState();
    _course = widget.selectedCourse;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _studentIdController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    debugPrint('Fluently course enrollment');
    debugPrint('Name: ${_nameController.text.trim()}');
    debugPrint('E-mail: ${_emailController.text.trim()}');
    debugPrint('Student ID: ${_studentIdController.text.trim()}');
    debugPrint('Course: ${_course!.title}');

    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Enrollment in ${_course!.title} submitted!'),
        backgroundColor: AppColors.violet,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight - 56),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: AppColors.blush,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.assignment_turned_in_outlined,
                      color: AppColors.coral,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Course enrollment',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Complete your details to enroll in the selected course.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 26),
                  _FieldLabel(
                    label: 'Full name',
                    child: TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().length < 3) {
                          return 'Enter your full name.';
                        }
                        return null;
                      },
                    ),
                  ),
                  _FieldLabel(
                    label: 'E-mail',
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'aluno@email.com',
                      ),
                      validator: (value) {
                        final email = value?.trim() ?? '';
                        if (!email.contains('@') || !email.contains('.')) {
                          return 'Enter a valid e-mail.';
                        }
                        return null;
                      },
                    ),
                  ),
                  _FieldLabel(
                    label: 'Student ID',
                    child: TextFormField(
                      controller: _studentIdController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Ex.: 20260175',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().length < 5) {
                          return 'Enter a valid student ID.';
                        }
                        return null;
                      },
                    ),
                  ),
                  _FieldLabel(
                    label: 'Selected course',
                    child: DropdownButtonFormField<Course>(
                      initialValue: _course,
                      isExpanded: true,
                      hint: const Text('Select a course'),
                      items: courses
                          .map(
                            (course) => DropdownMenuItem(
                              value: course,
                              child: Text(course.title),
                            ),
                          )
                          .toList(),
                      onChanged: (course) => setState(() => _course = course),
                      validator: (value) =>
                          value == null ? 'Select a course.' : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _submit,
                    icon: const Icon(Icons.send_outlined),
                    label: const Text('Submit enrollment'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (widget.embedded) return content;
    return Scaffold(
      appBar: AppBar(title: const Text('Enrollment')),
      body: content,
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
