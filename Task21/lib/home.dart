import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'chatpage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final supabase = Supabase.instance.client;
  List<dynamic> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final response = await supabase
          .from('allusers')
          .select()
          .order('created_at', ascending: false);

      setState(() {
        users = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في جلب المستخدمين: $e')),
      );
    }
  }

  void showUsersBottomSheet() {
    final currentUserId = supabase.auth.currentUser?.id;

    showModalBottomSheet(
      backgroundColor: const Color(0xFF2C2B36),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: 300,
          child: users.isEmpty
              ? const Center(
                  child: Text(
                    'لا يوجد مستخدمين',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];

                    // تجاهل المستخدم الحالي
                    if (user['id'] == currentUserId) return const SizedBox.shrink();

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          user['username'] != null && user['username'].length >= 2
                              ? user['username'].substring(0, 2).toUpperCase()
                              : '?',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      title: Text(
                        user['username'] ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        user['email'] ?? '',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        if (currentUserId != null && user['id'] != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                currentUserId: currentUserId,
                                otherUserId: user['id'],
                                otherUsername: user['username'] ?? '',
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تعذر الحصول على بيانات المستخدم')),
                          );
                        }
                      },
                    );
                  },
                ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1D25),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1D25),
        elevation: 0,
        title: const Text(
          "Chatify",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : const Text(
                '',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showUsersBottomSheet,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
