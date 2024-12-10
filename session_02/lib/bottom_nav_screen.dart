import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:session_02/app_router.dart';

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
      appBar: AppBar(),
      drawer: const PrimaryDrawer(),
      backgroundColor: const Color(0xFFF8F9FA),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          if (value == 0) {
            setState(() {
              currentIndex = 0;
            });
            const HomeRoute().push(context);
          }
          if (value == 1) {
            setState(() {
              currentIndex = 1;
            });
            FavouritesRoute().push(context);
          }
          if (value == 2) {
            setState(() {
              currentIndex = 2;
            });
            AccountRoute().push(context);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(
              Icons.home,
              color: Colors.amber,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            activeIcon: Icon(
              Icons.favorite,
              color: Colors.amber,
            ),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user),
            activeIcon: Icon(
              Icons.verified_user,
              color: Colors.amber,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

class PrimaryDrawer extends StatelessWidget {
  const PrimaryDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.abc),
                title: Text("1st Menu Item"),
              ),
              ListTile(
                leading: Icon(Icons.abc),
                title: Text("2nd Menu Item"),
              ),
              ListTile(
                leading: Icon(Icons.abc),
                title: Text("3rd Menu Item"),
              ),
              ListTile(
                leading: Icon(Icons.abc),
                title: Text("4th Menu Item"),
              ),
              ListTile(
                leading: Icon(Icons.abc),
                title: Text("5th Menu Item"),
              ),
              ListTile(
                leading: Icon(Icons.abc),
                title: Text("5th Menu Item"),
              ),
              ListTile(
                leading: Icon(Icons.abc),
                title: Text("5th Menu Item"),
              ),
              ListTile(
                leading: Icon(Icons.abc),
                title: Text("5th Menu Item"),
              ),
              ListTile(
                leading: Icon(Icons.abc),
                title: Text("5th Menu Item"),
              ),
              ListTile(
                leading: Icon(Icons.abc),
                title: Text("5th Menu Item"),
              ),
              ListTile(
                leading: Icon(Icons.abc),
                title: Text("5th Menu Item"),
              ),
              ListTile(
                leading: Icon(Icons.abc),
                title: Text("5th Menu Item"),
              ),
              ListTile(
                leading: Icon(Icons.abc),
                title: Text("5th Menu Item"),
              ),
              ListTile(
                leading: Icon(Icons.abc),
                title: Text("5th Menu Item"),
              ),
              ListTile(
                leading: Icon(Icons.abc),
                title: Text("5th Menu Item"),
              ),
              ListTile(
                leading: Icon(Icons.abc),
                title: Text("5th Menu Item"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
