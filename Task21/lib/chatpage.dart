import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatPage extends StatefulWidget {
  final String currentUserId;
  final String otherUserId;
  final String otherUsername;

  const ChatPage({
    super.key,
    required this.currentUserId,
    required this.otherUserId,
    required this.otherUsername,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final supabase = Supabase.instance.client;
  final TextEditingController messageController = TextEditingController();
  List<dynamic> messages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    try {
      final response = await supabase
          .from('messages')
          .select()
          .or('sender_id.eq.${widget.currentUserId},receiver_id.eq.${widget.currentUserId}')
          .order('created_at');

      setState(() {
        messages = response.where((msg) {
          return (msg['sender_id'] == widget.currentUserId &&
                  msg['receiver_id'] == widget.otherUserId) ||
              (msg['sender_id'] == widget.otherUserId &&
                  msg['receiver_id'] == widget.currentUserId);
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل في جلب الرسائل: $e')),
      );
    }
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    try {
      final message = {
        'sender_id': widget.currentUserId,
        'receiver_id': widget.otherUserId,
        'text': text,
      };

      await supabase.from('messages').insert(message);

      messageController.clear();
      fetchMessages();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل في إرسال الرسالة: $e')),
      );
    }
  }

  Widget _buildMessageItem(dynamic message) {
    final isMe = message['sender_id'] == widget.currentUserId;
    final senderName =
        isMe ? 'أنا' : widget.otherUsername;
    final initials = (senderName.length >= 2)
        ? senderName.substring(0, 2).toUpperCase()
        : senderName;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isMe ? Colors.blueAccent : Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMe)
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.deepPurple,
                child: Text(
                  initials,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            if (!isMe) const SizedBox(width: 6),
            Flexible(
              child: Text(
                message['text'] ?? '',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            if (isMe) const SizedBox(width: 6),
            if (isMe)
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.indigo,
                child: const Text(
                  'أنا',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1D25),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1D25),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text(
                widget.otherUsername.length >= 2
                    ? widget.otherUsername.substring(0, 2).toUpperCase()
                    : widget.otherUsername,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.otherUsername,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: messages.length,
                    itemBuilder: (context, index) =>
                        _buildMessageItem(messages[index]),
                  ),
          ),
          Container(
            color: const Color(0xFF2C2B36),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'اكتب رسالتك...',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(Icons.send, color: Colors.blueAccent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
