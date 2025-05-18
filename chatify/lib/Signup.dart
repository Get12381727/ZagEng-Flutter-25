import 'package:chatify/login.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chatify/Home.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final supabase = Supabase.instance.client;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> signup() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if ([username, email, password].any((e) => e.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك املأ جميع الحقول')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // إنشاء مستخدم جديد في Auth
      final res = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (res.user == null) throw 'حدث خطأ أثناء إنشاء الحساب';

      // إضافة بيانات المستخدم إلى جدول allusers
      await supabase.from('allusers').insert({
        'id': res.user!.id,
        'username': username,
        'email': email,
        'created_at': DateTime.now().toIso8601String(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إنشاء الحساب بنجاح!')),
      );

      // التوجيه لصفحة Home بعد التسجيل
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Home()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل التسجيل: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      fillColor: const Color.fromARGB(34, 0, 0, 0),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.all(17),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1D25),
      body: ListView(
        padding: const EdgeInsets.only(top: 100, right: 10, left: 10),
        children: [
          const Center(
            child: Text(
              "Chatify",
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
          const SizedBox(height: 70),
          TextField(
            controller: usernameController,
            style: const TextStyle(color: Colors.white),
            decoration: inputDecoration("Username"),
          ),
          const SizedBox(height: 45),
          TextField(
            controller: emailController,
            style: const TextStyle(color: Colors.white),
            decoration: inputDecoration("Email"),
          ),
          const SizedBox(height: 45),
          TextField(
            controller: passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: inputDecoration("Password"),
          ),
          const SizedBox(height: 45),
          Center(
            child: SizedBox(
              height: 45,
              width: 200,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: const Color(0xFF0052DA),
                onPressed: isLoading ? null : signup,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: TextButton(
              onPressed: () { Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Login()),
         );
              },
              child: const Text(
                "Already have an account?",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
