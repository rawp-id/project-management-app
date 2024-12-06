import 'package:flutter/material.dart';

class AddProjectView extends StatefulWidget {
  @override
  _AddProjectViewState createState() => _AddProjectViewState();
}

class _AddProjectViewState extends State<AddProjectView> {
  final _formKey = GlobalKey<FormState>();
  String projectName = '';
  String projectDescription = '';

  void _saveProject() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Simpan project ke database atau lakukan operasi lain
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Project "$projectName" has been created')),
      );
      Navigator.pop(context); // Kembali ke halaman sebelumnya
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Project'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Project Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: 'Enter project name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a project name';
                  }
                  return null;
                },
                onSaved: (value) => projectName = value ?? '',
              ),
              SizedBox(height: 20),
              Text(
                'Project Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Enter project description',
                ),
                maxLines: 4,
                onSaved: (value) => projectDescription = value ?? '',
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _saveProject,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    'Save Project',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
