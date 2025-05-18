import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'signup.dart';
import 'Home.dart';
import 'package:chatify/Home.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if ([email, password].any((e) => e.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك املأ جميع الحقول')),
      );
      return;
    }

    try {
      final res = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.user == null) throw 'حدث خطأ أثناء تسجيل الدخول';

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Home()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل الدخول: $e')),
      );
    }
  }

  void goToSignup() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Signup()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF1E1D25),
        child: ListView(
          padding: const EdgeInsets.only(top: 150, right: 10, left: 10),
          children: [
            const Center(
              child: Text(
                "Chatify",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 70),
            TextField(
              controller: emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: const TextStyle(color: Colors.white70),
                fillColor: const Color.fromARGB(34, 0, 0, 0),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(17),
              ),
            ),
            const SizedBox(height: 45),
            TextField(
              controller: passwordController,
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: const TextStyle(color: Colors.white70),
                fillColor: const Color.fromARGB(31, 0, 0, 0),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(17),
              ),
            ),
            const SizedBox(height: 45),
            Center(
              child: SizedBox(
                height: 45,
                width: 200,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: const Color(0xFF0052DA),
                  onPressed: login,
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: goToSignup,
                child: const Text(
                  "Don't have an account ?",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
