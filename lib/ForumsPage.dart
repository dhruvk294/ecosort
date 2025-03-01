import 'package:flutter/material.dart';

class Message {
  final String text;
  final String sender;
  final DateTime timestamp;

  Message({required this.text, required this.sender, required this.timestamp});
}

class ForumThread {
  final String title;
  final String creator;
  final List<Message> messages;
  final DateTime createdAt;

  ForumThread({
    required this.title,
    required this.creator,
    required this.messages,
    required this.createdAt,
  });
}

class ForumsPage extends StatefulWidget {
  const ForumsPage({super.key});

  @override
  _ForumsPageState createState() => _ForumsPageState();
}

class _ForumsPageState extends State<ForumsPage> {
  final List<ForumThread> _threads = [
    ForumThread(
      title: 'Tips for Recycling Paper',
      creator: 'EcoUser1',
      messages: [
        Message(
          text: 'What are some effective ways to recycle paper at home?',
          sender: 'EcoUser1',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Message(
          text:
              'I usually separate different types of paper - newspapers, cardboard, and office paper.',
          sender: 'GreenHelper',
          timestamp: DateTime.now().subtract(const Duration(hours: 12)),
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    ForumThread(
      title: 'Composting Discussion',
      creator: 'GardenGuru',
      messages: [
        Message(
          text: 'Started my first compost bin! Any tips?',
          sender: 'GardenGuru',
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  final TextEditingController _newThreadController = TextEditingController();

  void _createNewThread() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Thread'),
        content: TextField(
          controller: _newThreadController,
          decoration: const InputDecoration(
            hintText: 'Enter thread title',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_newThreadController.text.isNotEmpty) {
                setState(() {
                  _threads.insert(
                    0,
                    ForumThread(
                      title: _newThreadController.text,
                      creator: 'CurrentUser', // Replace with actual user
                      messages: [],
                      createdAt: DateTime.now(),
                    ),
                  );
                });
                _newThreadController.clear();
                Navigator.pop(context);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildForumHeader(),
          Expanded(
            child: _threads.isEmpty ? _buildEmptyState() : _buildThreadList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewThread,
        backgroundColor: Colors.green[700],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildForumHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border(
          bottom: BorderSide(
            color: Colors.green[200]!,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.forum, color: Colors.green[700], size: 24),
          const SizedBox(width: 8),
          Text(
            'Discussion Forums',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.forum_outlined,
            size: 64,
            color: Colors.green[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No discussions yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start a new thread to begin discussing!',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThreadList() {
    return ListView.builder(
      itemCount: _threads.length,
      itemBuilder: (context, index) {
        final thread = _threads[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Text(
              thread.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Created by ${thread.creator} • ${thread.messages.length} messages',
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.green[300]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThreadDetailPage(thread: thread),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ThreadDetailPage extends StatefulWidget {
  final ForumThread thread;

  const ThreadDetailPage({super.key, required this.thread});

  @override
  _ThreadDetailPageState createState() => _ThreadDetailPageState();
}

class _ThreadDetailPageState extends State<ThreadDetailPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.thread.title),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: widget.thread.messages.length,
              itemBuilder: (context, index) {
                final message = widget.thread.messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    final isCurrentUser = message.sender == 'CurrentUser';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isCurrentUser)
            CircleAvatar(
              backgroundColor: Colors.green[700],
              child: Text(
                message.sender[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isCurrentUser ? Colors.green[100] : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.sender,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(message.text),
                  const SizedBox(height: 4),
                  Text(
                    _formatTimestamp(message.timestamp),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isCurrentUser) const SizedBox(width: 8),
          if (isCurrentUser)
            CircleAvatar(
              backgroundColor: Colors.green[700],
              child: const Text(
                'CU',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              maxLines: null,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send, color: Colors.green[700]),
            onPressed: () {
              if (_messageController.text.isNotEmpty) {
                setState(() {
                  widget.thread.messages.add(
                    Message(
                      text: _messageController.text,
                      sender: 'CurrentUser', // Replace with actual user
                      timestamp: DateTime.now(),
                    ),
                  );
                });
                _messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
