import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _repasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_passwordController.text != _repasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    if (_usernameController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      // Replace with your actual registration logic
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _repasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
