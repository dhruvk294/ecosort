import 'package:flutter/material.dart';

// Global variable to store the current theme mode
ThemeMode currentThemeMode = ThemeMode.system;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Variable to keep track of theme selection
  ThemeMode selectedTheme = currentThemeMode;

  @override
  Widget build(BuildContext context) {
    return _buildContentPage([
      _buildSettingsOption(
        'Theme',
        'Change the app theme to light or dark mode.',
        onTap: _showThemeSelectionDialog,
      ),
      _buildSettingsOption(
        'Notifications',
        'Manage notification preferences and alerts.',
        onTap: _showNotificationsSettings,
      ),
      _buildSettingsOption(
        'Account',
        'Update your account information and password.',
        onTap: _manageAccountSettings,
      ),
      _buildSettingsOption(
        'Privacy',
        'Adjust privacy settings and permissions.',
        onTap: _managePrivacySettings,
      ),
      _buildSettingsOption(
        'About Us',
        'Learn more about the app and our team.',
        onTap: _showAboutUs,
      ),
      _buildSettingsOption(
        'Language',
        'Change the app language settings.',
        onTap: _changeLanguage,
      ),
      _buildSettingsOption(
        'Data Usage',
        'Manage data usage preferences for the app.',
        onTap: _manageDataUsage,
      ),
      _buildSettingsOption(
        'Help & Support',
        'Access help, support, and FAQ.',
        onTap: _helpAndSupport,
      ),
    ]);
  }

  // Reusable function to build the content
  Widget _buildContentPage(List<Widget> content) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[50]!, Colors.lightGreen[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20.0),
            ...content,
          ],
        ),
      ),
    );
  }

  // Reusable widget to create each settings option
  Widget _buildSettingsOption(String title, String description,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the theme selection dialog
  void _showThemeSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<ThemeMode>(
                title: const Text('System Default'),
                value: ThemeMode.system,
                groupValue: selectedTheme,
                onChanged: (ThemeMode? value) {
                  setState(() {
                    selectedTheme = value!;
                    _applyTheme(selectedTheme);
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<ThemeMode>(
                title: const Text('Light Mode'),
                value: ThemeMode.light,
                groupValue: selectedTheme,
                onChanged: (ThemeMode? value) {
                  setState(() {
                    selectedTheme = value!;
                    _applyTheme(selectedTheme);
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<ThemeMode>(
                title: const Text('Dark Mode'),
                value: ThemeMode.dark,
                groupValue: selectedTheme,
                onChanged: (ThemeMode? value) {
                  setState(() {
                    selectedTheme = value!;
                    _applyTheme(selectedTheme);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Apply the theme globally
  void _applyTheme(ThemeMode themeMode) {
    setState(() {
      currentThemeMode = themeMode;
    });
  }

  // Placeholder function for Notifications settings
  void _showNotificationsSettings() {
    // Code to open notifications settings can go here
    print("Notifications Settings clicked");
  }

  // Placeholder function for Account settings
  void _manageAccountSettings() {
    // Code to manage account settings can go here
    print("Manage Account Settings clicked");
  }

  // Placeholder function for Privacy settings
  void _managePrivacySettings() {
    // Code to manage privacy settings can go here
    print("Privacy Settings clicked");
  }

  // Placeholder function for About Us
  void _showAboutUs() {
    // Code to show About Us info can go here
    print("About Us clicked");
  }

  // Placeholder function for Language settings
  void _changeLanguage() {
    // Code to change language can go here
    print("Change Language clicked");
  }

  // Placeholder function for Data Usage
  void _manageDataUsage() {
    // Code to manage data usage can go here
    print("Manage Data Usage clicked");
  }

  // Placeholder function for Help & Support
  void _helpAndSupport() {
    // Code to provide help and support can go here
    print("Help & Support clicked");
  }
}

// Create a simple App for testing the theme settings
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Page Demo',
      themeMode: currentThemeMode, // Apply the selected theme mode
      theme: ThemeData.light(), // Light theme settings
      darkTheme: ThemeData.dark(), // Dark theme settings
      home: SettingsPage(),
    );
  }
}

void main() {
  runApp(MyApp());
}
