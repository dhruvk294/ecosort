import 'package:flutter/material.dart';
import 'models/UserRole.dart';
import 'models/Complaint.dart';
import 'ComplaintDetailPage.dart';

class AdminDashboardPage extends StatefulWidget {
  final User admin;

  const AdminDashboardPage({super.key, required this.admin});

  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _newAdminEmailController =
      TextEditingController();
  final TextEditingController _responseController = TextEditingController();

  // Sample complaint data - In a real app, this would come from a backend
  late Complaint _currentComplaint;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Initialize sample complaint
    _currentComplaint = Complaint(
      id: '1',
      userId: 'user123',
      userEmail: 'user@example.com',
      location: '123 Green Street, Eco City',
      description:
          'Large pile of mixed waste dumped near the park entrance. Requires immediate attention.',
      imageUrl: 'https://example.com/waste-image.jpg',
      dateSubmitted: DateTime.now().subtract(const Duration(hours: 2)),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _newAdminEmailController.dispose();
    _responseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.green[700],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.report_problem), text: 'Complaint'),
            Tab(icon: Icon(Icons.quiz), text: 'Quests'),
            Tab(icon: Icon(Icons.forum), text: 'Forums'),
            Tab(
                icon: Icon(Icons.admin_panel_settings),
                text: 'Admin Management'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildComplaintTab(),
          _buildQuestsTab(),
          _buildForumsTab(),
          _buildAdminManagementTab(),
        ],
      ),
    );
  }

  Widget _buildComplaintTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildComplaintHeader(),
          const SizedBox(height: 24),
          _buildComplaintImage(),
          const SizedBox(height: 24),
          _buildComplaintDetails(),
          const SizedBox(height: 24),
          _buildComplaintActions(),
        ],
      ),
    );
  }

  Widget _buildComplaintImage() {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Complaint Image',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.image,
                size: 64,
                color: Colors.grey[400],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplaintHeader() {
    return InkWell(
      onTap: () async {
        final updatedComplaint = await Navigator.push<Complaint>(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ComplaintDetailPage(complaint: _currentComplaint),
          ),
        );

        if (updatedComplaint != null) {
          setState(() {
            _currentComplaint = updatedComplaint;
          });
        }
      },
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.warning_rounded,
                    color: _getStatusColor(_currentComplaint.status),
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Waste Complaint #${_currentComplaint.id}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Status: ${_getStatusText(_currentComplaint.status)}',
                          style: TextStyle(
                            color: _getStatusColor(_currentComplaint.status),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComplaintDetails() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Complaint Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailItem('Reporter', _currentComplaint.userEmail),
            _buildDetailItem('Location', _currentComplaint.location),
            _buildDetailItem(
              'Date Submitted',
              _formatDate(_currentComplaint.dateSubmitted),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(_currentComplaint.description),
            if (_currentComplaint.adminResponse != null) ...[
              const SizedBox(height: 16),
              const Text(
                'Admin Response',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(_currentComplaint.adminResponse!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildComplaintActions() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _responseController,
              decoration: const InputDecoration(
                labelText: 'Response',
                hintText: 'Enter your response to the complaint',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _currentComplaint.status != 'in_progress'
                        ? () => _updateComplaintStatus('in_progress')
                        : null,
                    icon: const Icon(Icons.pending_actions),
                    label: const Text('Mark In Progress'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _currentComplaint.status != 'resolved'
                        ? () => _updateComplaintStatus('resolved')
                        : null,
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Mark Resolved'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.red;
      case 'in_progress':
        return Colors.orange;
      case 'resolved':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'in_progress':
        return 'In Progress';
      case 'resolved':
        return 'Resolved';
      default:
        return 'Unknown';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _updateComplaintStatus(String newStatus) {
    setState(() {
      _currentComplaint = _currentComplaint.copyWith(
        status: newStatus,
        adminResponse: _responseController.text.trim(),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Complaint status updated to ${_getStatusText(newStatus)}'),
        backgroundColor: _getStatusColor(newStatus),
      ),
    );
  }

  Widget _buildQuestsTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () {
              _showCreateQuestDialog();
            },
            icon: const Icon(Icons.add),
            label: const Text('Create New Quest'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 5, // Replace with actual quests count
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green[700],
                    child: const Icon(Icons.stars, color: Colors.white),
                  ),
                  title: Text('Quest #${index + 1}'),
                  subtitle: const Text('Reward: 100 points'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // TODO: Implement edit quest
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildForumsTab() {
    return ListView.builder(
      itemCount: 8, // Replace with actual forums count
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green[700],
              child: const Icon(Icons.forum, color: Colors.white),
            ),
            title: Text('Forum Topic #${index + 1}'),
            subtitle: Text('Posts: ${(index + 1) * 5}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.block),
                  color: Colors.orange,
                  onPressed: () {
                    // TODO: Implement block forum
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    _showDeleteForumDialog(index);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAdminManagementTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add New Admin',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _newAdminEmailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter email address',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          _addNewAdmin();
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add Admin'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Current Admins',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Card(
              elevation: 4,
              child: ListView.builder(
                itemCount: User.adminEmails.length,
                itemBuilder: (context, index) {
                  final email = User.adminEmails[index];
                  final isSuperAdmin = email == 'admin@ecosort.com';
                  return ListTile(
                    leading: Icon(
                      Icons.admin_panel_settings,
                      color: isSuperAdmin ? Colors.amber : Colors.green[700],
                    ),
                    title: Text(email),
                    subtitle: Text(isSuperAdmin ? 'Super Admin' : 'Admin'),
                    trailing: isSuperAdmin
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              _showRemoveAdminDialog(email);
                            },
                          ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateQuestDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create New Quest'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Quest Title',
                    hintText: 'Enter quest title',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter quest description',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Points Reward',
                    hintText: 'Enter points for completion',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement create quest
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
              ),
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteForumDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Forum'),
          content: Text(
              'Are you sure you want to delete Forum Topic #${index + 1}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement delete forum
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _addNewAdmin() {
    final email = _newAdminEmailController.text.trim();
    if (email.isEmpty) {
      _showErrorDialog('Please enter an email address.');
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      _showErrorDialog('Please enter a valid email address.');
      return;
    }

    if (User.addAdmin(email)) {
      setState(() {
        _newAdminEmailController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$email has been added as an admin.'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      _showErrorDialog('This email is already an admin.');
    }
  }

  void _showRemoveAdminDialog(String email) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remove Admin'),
          content: Text('Are you sure you want to remove $email as an admin?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (User.removeAdmin(email)) {
                  setState(() {});
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$email has been removed as an admin.'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
