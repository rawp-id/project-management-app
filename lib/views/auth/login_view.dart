import 'package:flutter/material.dart';
import 'package:project_app/services/api.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ApiService apiService = ApiService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    await apiService.logout();

    final result = await apiService.auth(
      _emailController.text,
      _passwordController.text,
    );

    print(result);

    if (result) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
