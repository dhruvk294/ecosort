import 'package:dashboard/DashboardPage.dart';
import 'package:flutter/material.dart';
import 'loginpage.dart'; // Import the login page

void main() {
  runApp(const EcoSortApp());
}

class EcoSortApp extends StatelessWidget {
  const EcoSortApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoSort',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          backgroundColor: Colors.green[700],
          centerTitle: true,
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
          elevation: 16.0,
        ),
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    const bool isAuthenticated = false; // Change this based on actual authentication logic

    if (isAuthenticated) {
      return const DashboardPage();
    } else {
      return  LoginPage(); // Redirect to LoginPage if not authenticated
    }
  }
}
