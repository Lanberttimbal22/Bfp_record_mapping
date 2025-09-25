import 'package:bfpms/pages/admin/a_establishments/a_establishments.dart';
import 'package:bfpms/pages/admin/a_staff_management/a_staff_management.dart';
import 'package:flutter/material.dart';
import '../admin/a_staff_assignment/a_assignment.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const StaffManagementScreen(),
    //const EstablishmentManagementScreen(),
    AdminEstablishment(),
    const AssignmentScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Landing'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Staff'),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Establishments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Assignments',
          ),
        ],
      ),
    );
  }
}
