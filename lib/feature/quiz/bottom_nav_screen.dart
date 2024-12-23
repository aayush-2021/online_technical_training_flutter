import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/core/app_router.dart';

enum MenuLabel { home, booking, chat, account }

class BottomNavScreen extends StatefulWidget {
  final StatefulNavigationShell child;
  const BottomNavScreen({
    super.key,
    required this.child,
  });

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: (value) {
          if (value == 0) {
            setState(() {
              currentIndex = 0;
            });
            HomeRoute().go(context);
          }
          if (value == 1) {
            setState(() {
              currentIndex = 1;
            });
            AccountRoute().go(context);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(
              Icons.home,
              color: Colors.blueAccent,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user),
            activeIcon: Icon(
              Icons.verified_user,
              color: Colors.blueAccent,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
